variable "prefix" {
  description = "Prefix for all resources"
  type        = string
}

variable "project" {
  description = "GCP project"
  type        = string
}

variable "project_number" {
  description = "GCP project number"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "terraform_deletion_protection" {
  type        = bool
  description = "Whether or not terraform can delete blobstore (GCS) data on destroy."
  default     = false
}
