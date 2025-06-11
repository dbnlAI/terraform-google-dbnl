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
}

variable "instance_type" {
  description = "Kubernetes node instance type"
  type        = string
}

variable "network_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "private_subnet_name" {
  description = "Name of the private subnet where GKE will run"
  type        = string
}

variable "kubernetes_control_plane_cidr" {
  type        = string
  description = "private IP block for GKE."
  default     = "10.0.3.0/28"
}

variable "gke_version" {
  type        = string
  description = "GKE version"
  default     = "1.29"
}

variable "desired_size" {
  type        = number
  description = "Desired size of GKE cluster"
  default     = 1
}

variable "terraform_deletion_protection" {
  type        = bool
  description = "Whether or not terraform can delete the Kubernetes cluster. If set to true, terraform will not be able to delete or replace the cluster unless this setting is changed and applied first."
  default     = false
}
