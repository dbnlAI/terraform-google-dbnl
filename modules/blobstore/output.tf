output "gcs_bucket" {
  description = "Google Cloud Storage bucket name"
  value       = module.google_storage_bucket.bucket.name
}

output "gcs_region" {
  description = "Google Cloud Storage bucket region"
  value       = module.google_storage_bucket.bucket.location
}

output "bucket_access_role" {
  description = "Bucket access role"
  value       = "projects/${var.project}/roles/${local.bucket_access_role_id}"
}
