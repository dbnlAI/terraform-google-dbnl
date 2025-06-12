terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.30"
    }
    # see: https://github.com/hashicorp/terraform-provider-google/issues/16275#issuecomment-1825752152
    # without this, terraform fails to cleanup peering connections on destroy
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~>5"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.5"
    }
  }

  required_version = ">= 1.2.0"
}
