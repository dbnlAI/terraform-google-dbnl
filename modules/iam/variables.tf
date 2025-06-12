variable "bucket_name" {
  description = "The name of the GCS bucket"
  type        = string
}

variable "bucket_access_role" {
  description = "The role to allow access to the bucket"
  type        = string
}

variable "dbnl_app_namespace" {
  description = "**Computed** namespace for launcehd DBNL app; ensures kubernetes service account creation."
  type        = string
}

variable "flower_enabled" {
  type        = bool
  description = "Enable Flower monitoring of Celery queues"
}

variable "helm_release_name" {
  description = "The name of the Helm release"
  type        = string
}

variable "project" {
  description = "The GCP project to deploy resources to"
  type        = string
}

variable "project_number" {
  description = "The GCP project number"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy resources to"
  type        = string
}

variable "prefix" {
  description = "The prefix to use for naming resources"
  type        = string
}
