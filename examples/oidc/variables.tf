variable "domain" {
  description = "Domain to deploy to."
  type        = string
}

variable "gcp_project" {
  description = "GCP project."
  type        = string
}

variable "gcp_region" {
  description = "GCP region."
  type        = string
}

variable "oidc_audience" {
  type        = string
  description = "OIDC audience."
}

variable "oidc_client_id" {
  type        = string
  description = "OIDC client id."
}

variable "oidc_issuer" {
  type        = string
  description = "OIDC issuer."
}

variable "oidc_scopes" {
  type        = string
  description = "OIDC scopes. Space-separated string."
  default     = "openid email profile"
}

variable "registry_password" {
  type        = string
  description = "Artifact / container registry password."
  sensitive   = true
}
