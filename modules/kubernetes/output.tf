output "cluster_name" {
  description = "GKE cluster name"
  value       = module.kubernetes.name
}

output "cluster_endpoint" {
  description = "GKE cluster endpoint"
  # NOTE: some users have seen this returned as sensitive, but it's not in this context
  value = nonsensitive(module.kubernetes.endpoint)
}

output "cluster_ca_certificate" {
  description = "GKE cluster CA certificate"
  # NOTE: some users have seen this returned as sensitive, but it's not in this context
  value = nonsensitive(module.kubernetes.ca_certificate)
}
