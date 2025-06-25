locals {
  oidc_enabled             = var.oidc_issuer != null && var.oidc_audience != null && var.oidc_client_id != null
  admin_enabled            = nonsensitive(var.admin_password != null)
  helm_repository_password = coalesce(var.helm_repository_password, var.registry_password)

  flower_basic_auth_enabled = nonsensitive(var.flower_basic_auth_username != null && var.flower_basic_auth_password != null)

  image_pull_secret = "${var.prefix}-docker-cfg"

  values = {
    imagePullSecrets = [
      {
        name = kubernetes_secret.image_pull_secret.metadata[0].name
      }
    ]
    api = {
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
      enabled   = true
      className = "gce"
      annotations = {
        "kubernetes.io/ingress.class"                 = "gce"
        "kubernetes.io/ingress.global-static-ip-name" = var.static_ip_name
        "ingress.gcp.kubernetes.io/pre-shared-cert"   = var.ingress_cert_name
      }
      host = var.domain
    }
    migration = {
      serviceAccount = {
        annotations = {
          "iam.gke.io/gcp-service-account" = var.gcp_service_account_emails["migration"]
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
      serviceAccount = {
        annotations = {
          "iam.gke.io/gcp-service-account" = var.gcp_service_account_emails["worker"]
        }
      }
    }
    ui = {
      serviceAccount = {
        annotations = {
          "iam.gke.io/gcp-service-account" = var.gcp_service_account_emails["ui"]
        }
      }
    }
    flower = var.flower_enabled ? {
      enabled = true
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
  repository_username = var.helm_repository_username
  repository_password = local.helm_repository_password

  values = [yamlencode(local.values)]

  dynamic "set_sensitive" {
    # for_each needs a list, but it's essentially a "count = ? 1 : 0"
    for_each = local.admin_enabled ? ["admin-enabled"] : []
    content {
      name  = "auth.admin.hashedPassword"
      value = bcrypt(var.admin_password)
    }
  }

  set_sensitive {
    name  = "auth.devToken.privateKey"
    value = var.dev_token_private_key
  }

  set_sensitive {
    name  = "redis.username"
    value = var.redis_username
  }

  set_sensitive {
    name  = "redis.password"
    value = var.redis_password
  }

  set_sensitive {
    name  = "db.username"
    value = var.db_username
  }

  set_sensitive {
    name  = "db.password"
    value = var.db_password
  }

  dynamic "set_sensitive" {
    for_each = local.flower_basic_auth_enabled ? ["flower-basic-auth-password"] : []
    content {
      name  = "flower.basicAuth.password"
      value = var.flower_basic_auth_password
    }
  }

  dynamic "set_sensitive" {
    for_each = local.flower_basic_auth_enabled ? ["flower-basic-auth-username"] : []
    content {
      name  = "flower.basicAuth.username"
      value = var.flower_basic_auth_username
    }
  }

  lifecycle {
    precondition {
      condition     = local.admin_enabled != local.oidc_enabled
      error_message = "One and only one of oidc or admin should be set."
    }
  }

  depends_on = [
    kubernetes_secret.image_pull_secret,
    var.ingress_cert_name,
    terraform_data.neg_cleanup,
  ]
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
