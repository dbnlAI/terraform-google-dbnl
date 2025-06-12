module "redis" {
  source  = "terraform-google-modules/memorystore/google"
  version = "~> 9.0"

  name    = "${var.prefix}-redis"
  tier    = "BASIC"
  project = var.project
  region  = var.region

  auth_enabled            = "true"
  authorized_network      = var.network_name
  redis_version           = "REDIS_7_2"
  transit_encryption_mode = "SERVER_AUTHENTICATION"

  reserved_ip_range = var.redis_subnet_cidr

  memory_size_gb = var.memory_size_gb
}
