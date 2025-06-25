data "google_client_config" "this" {}

data "google_project" "this" {
  project_id = data.google_client_config.this.project
}

locals {
  tls_cert = var.tls_cert != null ? file(var.tls_cert) : null
  tls_key  = var.tls_key != null ? file(var.tls_key) : null

  subnet_cidrs        = cidrsubnets(var.vpc_cidr, 8, 8, 8, 8)
  private_subnet_cidr = local.subnet_cidrs[0]
  public_subnet_cidr  = local.subnet_cidrs[1]
  redis_subnet_cidr   = local.subnet_cidrs[2]

  # NOTE: in GKE, control plane must be /28, so we replace the mask with 28
  kubernete_control_plane_cidr = "${split("/", local.subnet_cidrs[3])[0]}/28"

  helm_repository_password = coalesce(var.helm_repository_password, var.registry_password)
}

module "app" {
  source = "./modules/app"

  prefix = var.prefix

  # Helm chart info
  helm_chart_version       = var.helm_chart_version
  helm_repository_url      = var.helm_repository_url
  helm_repository_username = var.helm_repository_username
  helm_repository_password = local.helm_repository_password
  helm_release_name        = var.helm_release_name

  # Kubernetes images info
  registry_password          = var.registry_password
  registry_server            = var.registry_server
  registry_username          = var.registry_username
  gcp_service_account_emails = module.iam.gcp_service_account_emails
  private_subnet_name        = module.network.private_subnet_name

  # URL and HTTPS
  domain            = var.domain
  ingress_cert_name = module.network.ingress_cert_name
  static_ip_name    = module.network.static_ip_name

  # Database
  db_username      = module.database.username
  db_password      = module.database.password
  db_host          = module.database.host
  db_port          = module.database.port
  db_database_name = module.database.database_name

  # Caching and Queues
  redis_password        = module.redis.password
  redis_host            = module.redis.host
  redis_port            = module.redis.port
  redis_server_ca_certs = module.redis.server_ca_certs

  # Data storage
  gcs_bucket = module.blobstore.gcs_bucket
  gcs_region = module.blobstore.gcs_region

  # App Authentication
  admin_password            = var.admin_password
  dev_token_private_key     = var.dev_token_private_key
  oidc_audience             = var.oidc_audience
  oidc_client_id            = var.oidc_client_id
  oidc_issuer               = var.oidc_issuer
  oidc_scopes               = var.oidc_scopes
  terms_of_service_disabled = var.terms_of_service_disabled

  # (optional) Flower monitoring
  flower_enabled             = var.flower_enabled
  flower_basic_auth_password = var.flower_basic_auth_password
  flower_basic_auth_username = var.flower_basic_auth_username
}

module "blobstore" {
  source = "./modules/blobstore"

  prefix         = var.prefix
  project        = data.google_client_config.this.project
  project_number = data.google_project.this.number
  region         = data.google_client_config.this.region

  terraform_deletion_protection = var.terraform_deletion_protection
}

module "database" {
  source = "./modules/database"

  prefix  = var.prefix
  project = data.google_client_config.this.project
  region  = data.google_client_config.this.region

  instance_type                 = local.instance_types[var.instance_size].database
  network_url                   = module.network.network_url
  private_service_connection    = module.network.private_service_connection
  password                      = var.db_password
  terraform_deletion_protection = var.terraform_deletion_protection
}

module "iam" {
  source = "./modules/iam"

  prefix         = var.prefix
  project        = data.google_client_config.this.project
  project_number = data.google_project.this.number
  region         = data.google_client_config.this.region

  bucket_name        = module.blobstore.gcs_bucket
  bucket_access_role = module.blobstore.bucket_access_role
  helm_release_name  = var.helm_release_name
  dbnl_app_namespace = module.app.dbnl_app_namespace
  flower_enabled     = var.flower_enabled
}

module "kubernetes" {
  source = "./modules/kubernetes"

  prefix  = var.prefix
  project = data.google_client_config.this.project
  region  = data.google_client_config.this.region

  instance_type = local.instance_types[var.instance_size].kubernetes
  desired_size  = var.desired_size

  network_name                  = module.network.network_name
  private_subnet_name           = module.network.private_subnet_name
  kubernetes_control_plane_cidr = local.kubernete_control_plane_cidr
  terraform_deletion_protection = var.terraform_deletion_protection
}

module "network" {
  source = "./modules/network"

  prefix  = var.prefix
  project = data.google_client_config.this.project
  region  = data.google_client_config.this.region

  domain                       = var.domain
  user_provided_static_ip_name = var.user_provided_static_ip_name
  private_subnet_cidr          = local.private_subnet_cidr
  public_facing                = var.public_facing
  public_subnet_cidr           = local.public_subnet_cidr
  tls_cert                     = local.tls_cert
  tls_key                      = local.tls_key
}

module "redis" {
  source = "./modules/redis"

  prefix  = var.prefix
  project = data.google_client_config.this.project
  region  = data.google_client_config.this.region

  memory_size_gb    = local.instance_types[var.instance_size].redis
  network_name      = module.network.network_name
  redis_subnet_cidr = local.redis_subnet_cidr
}
