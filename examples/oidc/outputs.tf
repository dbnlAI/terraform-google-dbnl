output "cluster_name" {
  description = "Kubernetes cluster name"
  value       = module.dbnl.cluster_name
}

output "cluster_endpoint" {
  description = "Kubernetes cluster endpoint"
  value       = module.dbnl.cluster_endpoint
}

output "cluster_ca_certificate" {
  description = "Kubernetes cluster CA certificate"
  value       = module.dbnl.cluster_ca_certificate
}

output "load_balancer_static_ip" {
  description = "Static IP address for the load balancer. Set an A Record for your domain to this IP address with your DNS provider."
  value       = module.dbnl.load_balancer_static_ip
}
