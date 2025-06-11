output "dbnl_app_namespace" {
  description = "The **computed** namespace of the application, ensuring app and necessary resources have been created"
  value       = helm_release.dbnl.namespace
}
