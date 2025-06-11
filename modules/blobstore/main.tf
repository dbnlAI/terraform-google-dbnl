locals {
  # NOTE: limitations of the terraform IAM binding module require role names to be static
  # https://github.com/terraform-google-modules/terraform-google-iam/blob/50e81da40515d37bbe7127a6c8dead756ff0da06/README.md#caveats
  bucket_access_role_id = "dbnl_bucket_access_role"
}

resource "random_pet" "bucket_suffix" {
  length = 1
}

module "google_storage_bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 6.0"

  name       = "${var.prefix}-data-${random_pet.bucket_suffix.id}"
  project_id = var.project
  location   = var.region

  force_destroy            = !var.terraform_deletion_protection
  public_access_prevention = "enforced"
  versioning               = true
}

module "storage_object_access_role" {
  source = "terraform-google-modules/iam/google//modules/custom_role_iam"

  target_level = "project"
  target_id    = var.project
  role_id      = local.bucket_access_role_id
  title        = "${var.prefix}-blob-role"
  description  = "object upload/download permission for presigning URLs"
  permissions = [
    "storage.objects.get",
    "storage.objects.create",
    "storage.objects.delete",
  ]
}
