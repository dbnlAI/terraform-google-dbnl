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

variable "memory_size_gb" {
  description = "Redis memory size in GB"
  type        = string
}

variable "network_name" {
  description = "Name of authorized network"
  type        = string
}

variable "redis_subnet_cidr" {
  description = "Subnet cidr"
  type        = string
  default     = "10.0.2.0/24"
}
