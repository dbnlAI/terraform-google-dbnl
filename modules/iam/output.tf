output "gcp_service_account_emails" {
  description = "map of DBNL service to GCP Service Account emails"
  value = merge(
    {
      "api"       = google_service_account.api_sa.email
      "migration" = google_service_account.migration_sa.email
      "worker"    = google_service_account.worker_sa.email
      "ui"        = google_service_account.ui_sa.email
    },
    var.flower_enabled ? {
      "flower" = google_service_account.flower_sa[0].email
    } : {},
  )
}
