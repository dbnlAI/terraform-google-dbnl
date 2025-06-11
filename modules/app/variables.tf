variable "admin_password" {
  type        = string
  description = "Admin password."
  default     = null
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "Database password."
  sensitive   = true
}

variable "db_host" {
  type        = string
  description = "Database host."
}

variable "db_port" {
  type        = number
  description = "Database port."
  default     = 5432
}

variable "db_database_name" {
  type        = string
  description = "Database name."
  default     = "dbnl"
}

variable "db_username" {
  type        = string
  description = "Database username."
  sensitive   = true
}

variable "dev_token_private_key" {
  type        = string
  description = "Private key used to sign dev tokens."
  sensitive   = true
}

variable "domain" {
  type        = string
  description = "App domain."
}

variable "flower_enabled" {
  type        = bool
  description = "Whether to enable Flower monitoring for Celery queues."
  default     = false
}

variable "flower_basic_auth_password" {
  type        = string
  description = "Flower basic auth password for UI access."
  sensitive   = true
  default     = null
}

variable "flower_basic_auth_username" {
  type        = string
  description = "Flower basic auth username for UI access."
  sensitive   = true
  default     = null
}

variable "gcp_service_account_emails" {
  type        = map(string)
  description = "map of DBNL service to GCP service account emails"
}

variable "gcs_bucket" {
  type        = string
  description = "GCS bucket name."
}

variable "gcs_region" {
  type        = string
  description = "GCS bucket region."
}

variable "helm_chart_version" {
  type        = string
  description = "Helm Chart version."
}

variable "helm_release_name" {
  type        = string
  description = "Helm Release name."
  default     = "dbnl"
}

variable "helm_release_namespace" {
  type        = string
  description = "Helm Release namespace."
  default     = "default"
}

variable "helm_repository_url" {
  type        = string
  description = "Helm repository url."
}

variable "helm_repository_username" {
  type        = string
  description = "Helm repository username."
  sensitive   = true
}

variable "helm_repository_password" {
  type        = string
  description = "Helm repository password. If unset, defaults to `registry_password`."
  sensitive   = true
  default     = null
}

variable "ingress_cert_name" {
  type        = string
  description = "GCP name of TLS/SSL cert for ingress."
}

variable "oidc_audience" {
  type        = string
  description = "OIDC audience."
  default     = null
}

variable "oidc_client_id" {
  type        = string
  description = "OIDC client id."
  default     = null
}

variable "oidc_issuer" {
  type        = string
  description = "OIDC issuer."
  default     = null
}

variable "oidc_scopes" {
  type        = string
  description = "OIDC scopes. Space-separated string. Mutually exclusive with admin_password."
  default     = "openid email profile"
}

variable "prefix" {
  type        = string
  description = "Name prefix to apply to resources."
}

variable "public_facing" {
  type        = bool
  description = "If true, expose to app to public internet."
  default     = false
}

variable "redis_password" {
  type        = string
  description = "Redis password."
  sensitive   = true
}

variable "redis_host" {
  type        = string
  description = "Redis host."
}

variable "redis_port" {
  type        = number
  description = "Redis port."
  default     = 6379
}

variable "redis_username" {
  type        = string
  description = "Redis username."
  default     = "default"
  sensitive   = true
}

variable "registry_server" {
  type        = string
  description = "Image registry server."
  default     = "us-docker.pkg.dev/dbnlai"
}

variable "registry_username" {
  type        = string
  description = "Image registry username."
  sensitive   = true
}

variable "registry_password" {
  type        = string
  description = "Image registry password."
  sensitive   = true
}

variable "static_ip_name" {
  type        = string
  description = "GCP _name_ of static IP reserved for ingress."
}

variable "private_subnet_name" {
  type        = string
  description = "GCP name of private subnet."
}

variable "redis_server_ca_certs" {
  type        = string
  description = "Redis server CA certs."
}
