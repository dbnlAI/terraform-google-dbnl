variable "admin_password" {
  description = "Admin password."
  type        = string
  sensitive   = true
}

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
