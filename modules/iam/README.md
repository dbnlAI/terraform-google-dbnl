<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket_bindings"></a> [bucket\_bindings](#module\_bucket\_bindings) | terraform-google-modules/iam/google//modules/storage_buckets_iam | n/a |
| <a name="module_k8s_to_gcp_api_binding"></a> [k8s\_to\_gcp\_api\_binding](#module\_k8s\_to\_gcp\_api\_binding) | terraform-google-modules/iam/google//modules/service_accounts_iam | n/a |
| <a name="module_k8s_to_gcp_flower_binding"></a> [k8s\_to\_gcp\_flower\_binding](#module\_k8s\_to\_gcp\_flower\_binding) | terraform-google-modules/iam/google//modules/service_accounts_iam | n/a |
| <a name="module_k8s_to_gcp_migration_binding"></a> [k8s\_to\_gcp\_migration\_binding](#module\_k8s\_to\_gcp\_migration\_binding) | terraform-google-modules/iam/google//modules/service_accounts_iam | n/a |
| <a name="module_k8s_to_gcp_ui_binding"></a> [k8s\_to\_gcp\_ui\_binding](#module\_k8s\_to\_gcp\_ui\_binding) | terraform-google-modules/iam/google//modules/service_accounts_iam | n/a |
| <a name="module_k8s_to_gcp_worker_binding"></a> [k8s\_to\_gcp\_worker\_binding](#module\_k8s\_to\_gcp\_worker\_binding) | terraform-google-modules/iam/google//modules/service_accounts_iam | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project_service.cloud_resource_manager_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_project_service.service_usage_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.api_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.flower_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.migration_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.ui_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.worker_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_access_role"></a> [bucket\_access\_role](#input\_bucket\_access\_role) | The role to allow access to the bucket | `string` | n/a | yes |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the GCS bucket | `string` | n/a | yes |
| <a name="input_dbnl_app_namespace"></a> [dbnl\_app\_namespace](#input\_dbnl\_app\_namespace) | **Computed** namespace for launcehd DBNL app; ensures kubernetes service account creation. | `string` | n/a | yes |
| <a name="input_flower_enabled"></a> [flower\_enabled](#input\_flower\_enabled) | Enable Flower monitoring of Celery queues | `bool` | n/a | yes |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name) | The name of the Helm release | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix to use for naming resources | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The GCP project to deploy resources to | `string` | n/a | yes |
| <a name="input_project_number"></a> [project\_number](#input\_project\_number) | The GCP project number | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The GCP region to deploy resources to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gcp_service_account_emails"></a> [gcp\_service\_account\_emails](#output\_gcp\_service\_account\_emails) | map of DBNL service to GCP Service Account emails |
<!-- END_TF_DOCS -->