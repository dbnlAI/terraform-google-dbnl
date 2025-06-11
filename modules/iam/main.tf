locals {
  k8s_principal_base    = "principal://iam.googleapis.com/projects/${var.project_number}/locations/global/workloadIdentityPools/${var.project}.svc.id.goog"
  k8s_principal_sa_base = "${local.k8s_principal_base}/subject/ns/${var.dbnl_app_namespace}/sa"

  api_name       = "${var.helm_release_name}-api-srv"
  migration_name = "${var.helm_release_name}-migration-job"
  worker_name    = "${var.helm_release_name}-worker-srv"
  ui_name        = "${var.helm_release_name}-ui-srv"
  flower_name    = "${var.helm_release_name}-flower-srv"

  k8s_api_sa       = "${local.k8s_principal_sa_base}/${local.api_name}"
  k8s_migration_sa = "${local.k8s_principal_sa_base}/${local.migration_name}"
  k8s_worker_sa    = "${local.k8s_principal_sa_base}/${local.worker_name}"
  k8s_ui_sa        = "${local.k8s_principal_sa_base}/${local.ui_name}"
  k8s_flower_sa    = "${local.k8s_principal_sa_base}/${local.flower_name}"
}

resource "google_project_service" "service_usage_api" {
  project = var.project
  service = "serviceusage.googleapis.com"

  disable_on_destroy = false
}

resource "google_project_service" "cloud_resource_manager_api" {
  project = var.project
  service = "cloudresourcemanager.googleapis.com"

  disable_on_destroy = false
}

resource "google_service_account" "api_sa" {
  account_id   = "${var.prefix}-${local.api_name}"
  display_name = "${var.prefix}-${local.api_name}"
}

resource "google_service_account" "migration_sa" {
  account_id   = "${var.prefix}-${local.migration_name}"
  display_name = "${var.prefix}-${local.migration_name}"
}

resource "google_service_account" "worker_sa" {
  account_id   = "${var.prefix}-${local.worker_name}"
  display_name = "${var.prefix}-${local.worker_name}"
}

resource "google_service_account" "ui_sa" {
  account_id   = "${var.prefix}-${local.ui_name}"
  display_name = "${var.prefix}-${local.ui_name}"
}

resource "google_service_account" "flower_sa" {
  count        = var.flower_enabled ? 1 : 0
  account_id   = "${var.prefix}-${local.flower_name}"
  display_name = "${var.prefix}-${local.flower_name}"
}

module "bucket_bindings" {
  source          = "terraform-google-modules/iam/google//modules/storage_buckets_iam"
  mode            = "authoritative"
  storage_buckets = [var.bucket_name]

  bindings = {
    (var.bucket_access_role) = [
      google_service_account.api_sa.member,
      google_service_account.worker_sa.member,
      google_service_account.migration_sa.member,
    ]
  }
}

module "k8s_to_gcp_api_binding" {
  source = "terraform-google-modules/iam/google//modules/service_accounts_iam"

  project          = var.project
  mode             = "authoritative"
  service_accounts = [google_service_account.api_sa.email]

  bindings = {
    # connects K8s SA to GCP SA
    "roles/iam.workloadIdentityUser" = [local.k8s_api_sa]

    # required to presign URLs
    "roles/iam.serviceAccountTokenCreator" = [
      local.k8s_api_sa,
      google_service_account.api_sa.member,
    ]
  }
}

module "k8s_to_gcp_migration_binding" {
  source = "terraform-google-modules/iam/google//modules/service_accounts_iam"

  project          = var.project
  mode             = "authoritative"
  service_accounts = [google_service_account.migration_sa.email]

  bindings = {
    # connects K8s SA to GCP SA
    "roles/iam.workloadIdentityUser" = [local.k8s_migration_sa]
  }
}

module "k8s_to_gcp_worker_binding" {
  source = "terraform-google-modules/iam/google//modules/service_accounts_iam"

  project          = var.project
  mode             = "authoritative"
  service_accounts = [google_service_account.worker_sa.email]

  bindings = {
    # connects K8s SA to GCP SA
    "roles/iam.workloadIdentityUser" = [local.k8s_worker_sa]
  }
}

module "k8s_to_gcp_ui_binding" {
  source = "terraform-google-modules/iam/google//modules/service_accounts_iam"

  project          = var.project
  mode             = "authoritative"
  service_accounts = [google_service_account.ui_sa.email]

  bindings = {
    # connects K8s SA to GCP SA
    "roles/iam.workloadIdentityUser" = [local.k8s_ui_sa]
  }
}

module "k8s_to_gcp_flower_binding" {
  count  = var.flower_enabled ? 1 : 0
  source = "terraform-google-modules/iam/google//modules/service_accounts_iam"

  project          = var.project
  mode             = "authoritative"
  service_accounts = [google_service_account.flower_sa[0].email]

  bindings = {
    # connects K8s SA to GCP SA
    "roles/iam.workloadIdentityUser" = [local.k8s_flower_sa]
  }
}
