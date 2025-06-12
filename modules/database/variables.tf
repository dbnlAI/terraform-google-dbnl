variable "prefix" {
  description = "Prefix for all resources"
  type        = string
}

variable "project" {
  description = "GCP project"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "network_url" {
  description = "URL of the network the DB can connect to"
  type        = string
}

variable "instance_type" {
  description = "Database instance type attributes"
  type        = map(string)
}

variable "private_service_connection" {
  description = "explicit dependency on PSC creation in network"
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "dbnl"
}

variable "username" {
  description = "Username for the database"
  type        = string
  default     = "basic_user"
  sensitive   = true
}

variable "password" {
  description = "Password for the database"
  type        = string
  sensitive   = true
}

variable "terraform_deletion_protection" {
  type        = bool
  description = "Whether or not terraform can delete the database. If set to true, terraform will not be able to delete or replace the database unless this setting is changed and applied first."
  default     = false
}
