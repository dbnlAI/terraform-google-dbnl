output "ingress_cert_name" {
  description = "Name of the certificate resource"
  value = (
    local.user_provided_certs ?
    google_compute_ssl_certificate.ingress_cert[0].name
    : google_compute_managed_ssl_certificate.ingress_cert[0].name
  )
}

output "network_name" {
  description = "GCP name of the network"
  value       = module.vpc.network_name
}

output "network_url" {
  description = "GCP (internal) URL of the network"
  value       = module.vpc.network_self_link
}

output "private_subnet_name" {
  description = "GCP name of the private subnet"
  value       = module.vpc.subnets_names[0]
}

output "private_service_connection" {
  description = "GCP private service connection for connecting to DB/Redis"
  value       = google_service_networking_connection.private_service_connection
}

output "static_ip" {
  description = "Static IP address, used for Kubernetes Ingress"
  value = (
    local.reserve_new_static_ip ?
    module.static_ip[0].addresses[0] :
    data.google_compute_address.static_ip[0].address
  )
}

output "static_ip_name" {
  description = "GCP name of Static IP, used for Kubernetes Ingress"
  value = (
    local.reserve_new_static_ip ?
    module.static_ip[0].names[0] :
    data.google_compute_address.static_ip[0].name
  )
}
