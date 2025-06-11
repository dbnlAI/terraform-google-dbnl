provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

provider "google-beta" {
  project = var.gcp_project
  region  = var.gcp_region
}

data "google_client_config" "current" {}

data "google_project" "project" {
  project_id = data.google_client_config.current.project
}

provider "kubernetes" {
  host                   = "https://${module.dbnl.cluster_endpoint}"
  cluster_ca_certificate = base64decode(module.dbnl.cluster_ca_certificate)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "gke-gcloud-auth-plugin"
    args        = []
  }
}

provider "helm" {
  kubernetes {
    host                   = "https://${module.dbnl.cluster_endpoint}"
    cluster_ca_certificate = base64decode(module.dbnl.cluster_ca_certificate)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "gke-gcloud-auth-plugin"
      args        = []
    }
  }
}

# Generate a random prefix.
resource "random_pet" "prefix" {
  length = 1
}

# Generate a random dev key.
resource "tls_private_key" "dev" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generate a random database password.
resource "random_string" "db_password" {
  length  = 20
  special = false
}

# Create dbnl module.
module "dbnl" {
  source = "../../"

  db_password           = random_string.db_password.id
  dev_token_private_key = tls_private_key.dev.private_key_pem
  domain                = var.domain
  helm_chart_version    = "0.0.37"
  instance_size         = "small"
  oidc_audience         = var.oidc_audience
  oidc_issuer           = var.oidc_issuer
  oidc_client_id        = var.oidc_client_id
  oidc_scopes           = var.oidc_scopes
  prefix                = random_pet.prefix.id
  public_facing         = true
  registry_password     = var.registry_password
}
