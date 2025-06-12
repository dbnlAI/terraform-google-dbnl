locals {
  reserve_new_static_ip = var.user_provided_static_ip_name == null
  user_provided_certs   = var.tls_cert != null && var.tls_key != null
}

resource "random_pet" "suffix" {
  length = 1
  keepers = {
    tls_cert = var.tls_cert
    tls_key  = var.tls_key
  }
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 9.1"

  project_id   = var.project
  network_name = "${var.prefix}-vpc"
  routing_mode = "GLOBAL"

  subnets = [
    {
      subnet_name           = "private-subnet-01"
      subnet_ip             = var.private_subnet_cidr
      subnet_region         = var.region
      subnet_private_access = true
    },
    {
      subnet_name           = "public-subnet-01"
      subnet_ip             = var.public_subnet_cidr
      subnet_region         = var.region
      subnet_private_access = false
    }
  ]
}

resource "google_compute_global_address" "vpc_peering" {
  provider = google-beta

  name          = "${var.prefix}-vpc-peering"
  project       = var.project
  address_type  = "INTERNAL"
  purpose       = "VPC_PEERING"
  prefix_length = 16
  network       = module.vpc.network_self_link
}

resource "google_project_service" "service_networking_api" {
  project = var.project
  service = "servicenetworking.googleapis.com"

  disable_on_destroy = false
}

resource "google_service_networking_connection" "private_service_connection" {
  provider = google-beta

  network                 = module.vpc.network_self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.vpc_peering.name]
  deletion_policy         = "ABANDON"

  depends_on = [
    google_project_service.service_networking_api,
  ]
}

module "cloud_nat" {
  source  = "terraform-google-modules/cloud-nat/google"
  version = "~> 5.0"

  name       = "${var.prefix}-nat-gateway"
  project_id = var.project
  region     = var.region

  network       = module.vpc.network_name
  create_router = true
  router        = "${var.prefix}-router"
}

resource "google_compute_managed_ssl_certificate" "ingress_cert" {
  count    = local.user_provided_certs ? 0 : 1
  provider = google-beta

  name    = "${var.prefix}-ingress-certs-${random_pet.suffix.id}"
  project = var.project

  managed {
    domains = [var.domain]
  }
}

resource "google_compute_ssl_certificate" "ingress_cert" {
  count    = local.user_provided_certs ? 1 : 0
  provider = google-beta

  name    = "${var.prefix}-user-provided-ingress-certs-${random_pet.suffix.id}"
  project = var.project

  certificate = random_pet.suffix.keepers.tls_cert
  private_key = random_pet.suffix.keepers.tls_key

  lifecycle {
    create_before_destroy = true
  }
}

data "google_compute_address" "static_ip" {
  count = local.reserve_new_static_ip ? 0 : 1

  name    = var.user_provided_static_ip_name
  project = var.project
}

module "static_ip" {
  count = local.reserve_new_static_ip ? 1 : 0

  source  = "terraform-google-modules/address/google"
  version = "~> 3.1"

  project_id = var.project
  region     = var.region

  names = ["${var.prefix}-static-ingress-ip"]

  global       = var.public_facing
  address_type = var.public_facing ? "EXTERNAL" : "INTERNAL"
  subnetwork   = var.public_facing ? null : module.vpc.subnets_names[0]
}
