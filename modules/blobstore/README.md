<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_google_storage_bucket"></a> [google\_storage\_bucket](#module\_google\_storage\_bucket) | terraform-google-modules/cloud-storage/google//modules/simple_bucket | ~> 6.0 |
| <a name="module_storage_object_access_role"></a> [storage\_object\_access\_role](#module\_storage\_object\_access\_role) | terraform-google-modules/iam/google//modules/custom_role_iam | n/a |

## Resources

| Name | Type |
|------|------|
| [random_pet.bucket_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all resources | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | GCP project | `string` | n/a | yes |
| <a name="input_project_number"></a> [project\_number](#input\_project\_number) | GCP project number | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | `"us-central1"` | no |
| <a name="input_terraform_deletion_protection"></a> [terraform\_deletion\_protection](#input\_terraform\_deletion\_protection) | Whether or not terraform can delete blobstore (GCS) data on destroy. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_access_role"></a> [bucket\_access\_role](#output\_bucket\_access\_role) | Bucket access role |
| <a name="output_gcs_bucket"></a> [gcs\_bucket](#output\_gcs\_bucket) | Google Cloud Storage bucket name |
| <a name="output_gcs_region"></a> [gcs\_region](#output\_gcs\_region) | Google Cloud Storage bucket region |
<!-- END_TF_DOCS -->