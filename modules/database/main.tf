module "db" {
  source  = "terraform-google-modules/sql-db/google//modules/postgresql"
  version = "~> 20.1"

  project_id        = var.project
  name              = "${var.prefix}-db-instance"
  database_version  = "POSTGRES_15"
  availability_type = "REGIONAL"
  tier              = var.instance_type.tier
  disk_size         = var.instance_type.size
  disk_autoresize   = false

  deletion_protection      = var.terraform_deletion_protection
  database_deletion_policy = "ABANDON"
  user_deletion_policy     = "ABANDON"

  maintenance_window_day          = 7
  maintenance_window_hour         = 12
  maintenance_window_update_track = "stable"

  database_flags = [{
    name  = "autovacuum"
    value = "on"
  }]

  ip_configuration = {
    ipv4_enabled    = false
    ssl_mode        = "ENCRYPTED_ONLY"
    private_network = var.network_url
  }

  backup_configuration = {
    enabled                        = true
    point_in_time_recovery_enabled = true
    start_time                     = "03:00"
    retained_backups               = 14
    retention_unit                 = "COUNT"
  }

  db_name      = var.db_name
  db_charset   = "UTF8"
  db_collation = "en_US.UTF8"

  user_name     = var.username
  user_password = var.password

  depends_on = [
    var.private_service_connection
  ]
}
