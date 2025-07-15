variable "admin_password" {
  type        = string
  description = "Admin password. Mutually exclusive with OIDC settings"
  default     = null
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "Database password."
  sensitive   = true
}

variable "terraform_deletion_protection" {
  type        = bool
  description = "Whether or not terraform can delete resources such as database and kubernetes cluster. If set to true, terraform will not be able to delete or replace these resources."
  default     = false
}

variable "desired_size" {
  type        = number
  description = "Desired number of GKE nodes."
  default     = 1
}

variable "dev_token_private_key" {
  type        = string
  description = "Private key used to sign dev tokens."
  default     = ""
  sensitive   = true
}

variable "domain" {
  type        = string
  description = "App domain name."
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
  description = "Namespace for helm release."
  default     = "default"
}

variable "helm_repository_username" {
  type        = string
  description = "Username for accessing helm chart repository."
  sensitive   = true
  default     = null
}

variable "helm_repository_password" {
  type        = string
  description = "Password for accessing helm chart repository. If unset, defaults to `registry_password`"
  sensitive   = true
  default     = null
}

variable "helm_repository_url" {
  type        = string
  description = "URL for accessing helm chart repository."
  default     = "oci://ghcr.io/dbnlai/charts/dbnl"
}

variable "instance_size" {
  type        = string
  description = "App instance size."

  validation {
    condition     = contains(["small", "medium"], var.instance_size)
    error_message = "instance_size should be one of [\"small\", \"medium\"]."
  }
}

variable "oidc_audience" {
  type        = string
  description = "OIDC audience. Mutually exclusive with admin_password."
  default     = null
}

variable "oidc_client_id" {
  type        = string
  description = "OIDC client id. Mutually exclusive with admin_password."
  default     = null
}

variable "oidc_issuer" {
  type        = string
  description = "OIDC issuer. Mutually exclusive with admin_password."
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
  description = "Whether the app is public facing."
  default     = false
}

variable "registry_server" {
  type        = string
  description = "Image registry server."
  default     = "ghcr.io/dbnlai"
}

variable "registry_username" {
  type        = string
  description = "Image registry username."
  sensitive   = true
  default     = null
}

variable "registry_password" {
  type        = string
  description = "Image registry password."
  sensitive   = true
  default     = null
}

variable "tls_cert" {
  type        = string
  description = "TLS certificate, if providing your own. Will be stored as Kubernetes secret."
  default     = null
  sensitive   = true
}

variable "tls_key" {
  type        = string
  description = "TLS key, if providing your own. Will be stored as Kubernetes secret."
  default     = null
  sensitive   = true
}

variable "user_provided_static_ip_name" {
  type        = string
  description = "GCP name of Static IP Resource if it has already been reserved. This allows you to pre-register the A Record in your DNS provider for the GKE Load Balancer."
  default     = null
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR."
  default     = "192.168.0.0/16"
}

variable "terms_of_service_disabled" {
  type        = bool
  description = "Whether to disable the terms of service acceptance requirement."
  default     = false
}
