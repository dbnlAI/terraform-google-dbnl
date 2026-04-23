locals {
  oidc_enabled             = var.oidc_issuer != null && var.oidc_audience != null && var.oidc_client_id != null
  admin_enabled            = nonsensitive(var.admin_password != null)
  helm_repository_username = try(coalesce(var.helm_repository_username, var.registry_username), null)
  helm_repository_password = try(coalesce(var.helm_repository_password, var.registry_password), null)

  flower_basic_auth_enabled = nonsensitive(var.flower_basic_auth_username != null && var.flower_basic_auth_password != null)

  image_tag = coalesce(var.image_tag, var.helm_chart_version)

  image_pull_secret = "${var.prefix}-docker-cfg"

  values = {
    imagePullSecrets = length(kubernetes_secret.image_pull_secret) > 0 ? [
      {
        name = kubernetes_secret.image_pull_secret[0].metadata[0].name
      }
    ] : []
    api = {
      baseUrl = "https://${var.domain}/api"
      image = {
        repository = "${var.registry_server}/images/api-srv"
        tag        = local.image_tag
      }
      serviceAccount = {
        annotations = {
          "iam.gke.io/gcp-service-account" = var.gcp_service_account_emails["api"]
        }
      }
    }
    auth = {
      admin = {
        enabled = local.admin_enabled
      }
      devToken = {
        audience = "http://${var.domain}"
        issuer   = "http://${var.domain}"
      }
      oidc = {
        enabled  = local.oidc_enabled
        issuer   = var.oidc_issuer
        audience = var.oidc_audience
        clientId = var.oidc_client_id
        scopes   = var.oidc_scopes
      }
    }
    db = {
      host     = var.db_host
      port     = var.db_port
      database = var.db_database_name
    }
    ingress = {
      enabled = false
    }
    migration = {
      image = {
        repository = "${var.registry_server}/images/migration-job"
        tag        = local.image_tag
      }
      serviceAccount = {
        annotations = {
          "iam.gke.io/gcp-service-account" = var.gcp_service_account_emails["migration"]
        }
      }
    }
    scheduler = {
      enabled = true
      image = {
        repository = "${var.registry_server}/images/scheduler-srv"
        tag        = local.image_tag
      }
      serviceAccount = {
        annotations = {
          "iam.gke.io/gcp-service-account" = var.gcp_service_account_emails["scheduler"]
        }
      }
    }
    redis = {
      host = var.redis_host
      port = var.redis_port
      tls = {
        enabled = true
        caCert  = var.redis_server_ca_certs
      }
    }
    storage = {
      gcs = {
        enabled = true
        bucket  = var.gcs_bucket
        region  = var.gcs_region
      }
    }
    worker = {
      image = {
        repository = "${var.registry_server}/images/worker-srv"
        tag        = local.image_tag
      }
      realtime = {
        enabled = true
      }
      serviceAccount = {
        annotations = {
          "iam.gke.io/gcp-service-account" = var.gcp_service_account_emails["worker"]
        }
      }
    }
    ui = {
      baseUrl = "https://${var.domain}"
      image = {
        repository = "${var.registry_server}/images/ui-srv"
        tag        = local.image_tag
      }
      serviceAccount = {
        annotations = {
          "iam.gke.io/gcp-service-account" = var.gcp_service_account_emails["ui"]
        }
      }
    }
    flower = var.flower_enabled ? {
      enabled = true
      image = {
        repository = "${var.registry_server}/images/flower-srv"
        tag        = local.image_tag
      }
      serviceAccount = {
        annotations = {
          "iam.gke.io/gcp-service-account" = var.gcp_service_account_emails["flower"]
        }
      }
      port = 5555
      basicAuth = {
        enabled = local.flower_basic_auth_enabled
      }
      } : {
      enabled = false
      image = {
        repository = "${var.registry_server}/images/flower-srv"
        tag        = local.image_tag
      }
      serviceAccount = {
        annotations = {
          "iam.gke.io/gcp-service-account" = ""
        }
      }
      port = 0
      basicAuth = {
        enabled = false
      }
    }
    tos = {
      disabled = var.terms_of_service_disabled
    }
  }
}

resource "kubernetes_secret" "image_pull_secret" {
  count = (var.registry_username != null && var.registry_password != null) ? 1 : 0

  metadata {
    name = local.image_pull_secret
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${var.registry_server}" = {
          "username" = var.registry_username
          "password" = var.registry_password
          "auth"     = base64encode("${var.registry_username}:${var.registry_password}")
        }
      }
    })
  }
}

resource "helm_release" "dbnl" {
  chart     = "dbnl"
  name      = var.helm_release_name
  namespace = var.helm_release_namespace
  version   = var.helm_chart_version

  repository          = var.helm_repository_url
  repository_username = local.helm_repository_username
  repository_password = local.helm_repository_password

  values = [yamlencode(local.values)]

  set_sensitive = concat(
    [
      { name = "auth.devToken.privateKey", value = var.dev_token_private_key },
      { name = "redis.username", value = var.redis_username },
      { name = "redis.password", value = var.redis_password },
      { name = "db.username", value = var.db_username },
      { name = "db.password", value = var.db_password },
    ],
    local.admin_enabled ? [
      { name = "auth.admin.hashedPassword", value = bcrypt(var.admin_password) },
    ] : [],
    local.flower_basic_auth_enabled ? [
      { name = "flower.basicAuth.password", value = var.flower_basic_auth_password },
      { name = "flower.basicAuth.username", value = var.flower_basic_auth_username },
    ] : [],
  )

  lifecycle {
    precondition {
      condition     = local.admin_enabled != local.oidc_enabled
      error_message = "One and only one of oidc or admin should be set."
    }
  }

  depends_on = [
    kubernetes_secret.image_pull_secret,
    terraform_data.neg_cleanup,
  ]
}

resource "kubernetes_ingress_v1" "dbnl" {
  metadata {
    name      = "${var.helm_release_name}-ingress"
    namespace = var.helm_release_namespace
    annotations = {
      "kubernetes.io/ingress.class"                 = "gce"
      "kubernetes.io/ingress.global-static-ip-name" = var.static_ip_name
      "ingress.gcp.kubernetes.io/pre-shared-cert"   = var.ingress_cert_name
    }
  }

  spec {
    ingress_class_name = "gce"
    rule {
      host = var.domain
      http {
        path {
          path      = "/api"
          path_type = "Prefix"
          backend {
            service {
              name = "${var.helm_release_name}-api-srv"
              port { number = 80 }
            }
          }
        }
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "${var.helm_release_name}-ui-srv"
              port { number = 80 }
            }
          }
        }
      }
    }
  }

  depends_on = [helm_release.dbnl]
}

# NOTE: Helm chart creates ingress which in turn creates a load balancer that puts a NEG in each zone.
# However, on Helm destroy and even on Kubernetes destroy, the NEG is not deleted, and not tracked by terraform.
# We need the NEGs deleted in order to spin down the VPC on a total destroy.
# We make helm_release depend on this (which is a no-op on create), so that on destroy, the app is deleted first, and then the NEGs are deleted.
resource "terraform_data" "neg_cleanup" {
  triggers_replace = [
    var.private_subnet_name
  ]

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
for NEG in $(gcloud compute network-endpoint-groups list --filter="subnetwork:(${self.triggers_replace[0]})" --format="value(name)");
do
  for ZONE in $(gcloud compute network-endpoint-groups list --filter="name:($NEG)" --format="value(zone)");
  do
    echo "Deleting NEG $NEG in zone $ZONE"
    gcloud compute network-endpoint-groups delete $NEG --zone $ZONE --quiet
  done
done
EOT
  }
}
