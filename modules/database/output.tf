output "host" {
  description = "The (internal) host of the database"
  value       = module.db.instance_first_ip_address
}

# NOTE: doesn't appear to be configurable
output "port" {
  description = "The port of the database"
  value       = 5432
}

output "database_name" {
  description = "The name of the database"
  value       = var.db_name
}

output "username" {
  description = "The username for the database"
  value       = var.username
  sensitive   = true
}

output "password" {
  description = "The password for the database"
  value       = var.password
  sensitive   = true
}
