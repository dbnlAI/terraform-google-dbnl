output "cluster_name" {
  description = "Kubernetes cluster name"
  value       = module.kubernetes.cluster_name
}

output "cluster_endpoint" {
  description = "Kubernetes cluster endpoint"
  value       = module.kubernetes.cluster_endpoint
}

output "cluster_ca_certificate" {
  description = "Kubernetes cluster CA certificate"
  value       = module.kubernetes.cluster_ca_certificate
}

output "load_balancer_static_ip" {
  description = "Static IP address for the load balancer"
  value       = module.network.static_ip
}

output "load_balancer_name" {
  description = "GCP name of the load balancer"
  value       = module.network.static_ip_name
}
