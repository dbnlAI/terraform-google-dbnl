variable "domain" {
  description = "Domain name"
  type        = string
}

variable "prefix" {
  type        = string
  description = "Name prefix to apply to named resources."
}

variable "project" {
  type        = string
  description = "GCP project."
}

variable "region" {
  type        = string
  description = "GCP region."
  default     = "us-central1"
}

variable "private_subnet_cidr" {
  type        = string
  description = "Private subnet cidr."
  default     = "10.0.0.0/24"
}

variable "public_facing" {
  description = "Is this environment public facing?"
  type        = bool
}

variable "public_subnet_cidr" {
  type        = string
  description = "Public subnet cidr."
  default     = "10.0.1.0/24"
}

variable "tls_cert" {
  type        = string
  description = "TLS certificate, if providing your own. WARNING: this will be stored in plaintext in the state file."
  default     = null
  sensitive   = true
}

variable "tls_key" {
  type        = string
  description = "TLS key, if providing your own. WARNING: this will be stored in plaintext in the state file."
  default     = null
  sensitive   = true
}

variable "user_provided_static_ip_name" {
  type        = string
  description = "GCP name of Static IP Resource if it has already been reserved. This allows you to pre-register the A Record in your DNS provider for the GKE Load Balancer."
  default     = null
}
