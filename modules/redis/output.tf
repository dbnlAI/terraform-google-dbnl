output "host" {
  description = "Redis instance host"
  value       = module.redis.host

}
output "port" {
  description = "Redis instance port"
  value       = module.redis.port
}

output "username" {
  description = "Redis instance username"
  value       = "default"
  sensitive   = true
}

output "password" {
  description = "Redis instance password"
  value       = module.redis.auth_string
  sensitive   = true
}

output "server_ca_certs" {
  description = "Redis instance server CA certificates"
  value       = join("\n", module.redis.server_ca_certs[*].cert)
}
