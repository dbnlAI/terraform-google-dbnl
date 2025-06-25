<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.dbnl](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_secret.image_pull_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [terraform_data.neg_cleanup](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Admin password. | `string` | `null` | no |
| <a name="input_db_database_name"></a> [db\_database\_name](#input\_db\_database\_name) | Database name. | `string` | `"dbnl"` | no |
| <a name="input_db_host"></a> [db\_host](#input\_db\_host) | Database host. | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Database password. | `string` | n/a | yes |
| <a name="input_db_port"></a> [db\_port](#input\_db\_port) | Database port. | `number` | `5432` | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Database username. | `string` | n/a | yes |
| <a name="input_dev_token_private_key"></a> [dev\_token\_private\_key](#input\_dev\_token\_private\_key) | Private key used to sign dev tokens. | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | App domain. | `string` | n/a | yes |
| <a name="input_flower_basic_auth_password"></a> [flower\_basic\_auth\_password](#input\_flower\_basic\_auth\_password) | Flower basic auth password for UI access. | `string` | `null` | no |
| <a name="input_flower_basic_auth_username"></a> [flower\_basic\_auth\_username](#input\_flower\_basic\_auth\_username) | Flower basic auth username for UI access. | `string` | `null` | no |
| <a name="input_flower_enabled"></a> [flower\_enabled](#input\_flower\_enabled) | Whether to enable Flower monitoring for Celery queues. | `bool` | `false` | no |
| <a name="input_gcp_service_account_emails"></a> [gcp\_service\_account\_emails](#input\_gcp\_service\_account\_emails) | map of DBNL service to GCP service account emails | `map(string)` | n/a | yes |
| <a name="input_gcs_bucket"></a> [gcs\_bucket](#input\_gcs\_bucket) | GCS bucket name. | `string` | n/a | yes |
| <a name="input_gcs_region"></a> [gcs\_region](#input\_gcs\_region) | GCS bucket region. | `string` | n/a | yes |
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version) | Helm Chart version. | `string` | n/a | yes |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name) | Helm Release name. | `string` | `"dbnl"` | no |
| <a name="input_helm_release_namespace"></a> [helm\_release\_namespace](#input\_helm\_release\_namespace) | Helm Release namespace. | `string` | `"default"` | no |
| <a name="input_helm_repository_password"></a> [helm\_repository\_password](#input\_helm\_repository\_password) | Helm repository password. If unset, defaults to `registry_password`. | `string` | `null` | no |
| <a name="input_helm_repository_url"></a> [helm\_repository\_url](#input\_helm\_repository\_url) | Helm repository url. | `string` | n/a | yes |
| <a name="input_helm_repository_username"></a> [helm\_repository\_username](#input\_helm\_repository\_username) | Helm repository username. | `string` | n/a | yes |
| <a name="input_ingress_cert_name"></a> [ingress\_cert\_name](#input\_ingress\_cert\_name) | GCP name of TLS/SSL cert for ingress. | `string` | n/a | yes |
| <a name="input_oidc_audience"></a> [oidc\_audience](#input\_oidc\_audience) | OIDC audience. | `string` | `null` | no |
| <a name="input_oidc_client_id"></a> [oidc\_client\_id](#input\_oidc\_client\_id) | OIDC client id. | `string` | `null` | no |
| <a name="input_oidc_issuer"></a> [oidc\_issuer](#input\_oidc\_issuer) | OIDC issuer. | `string` | `null` | no |
| <a name="input_oidc_scopes"></a> [oidc\_scopes](#input\_oidc\_scopes) | OIDC scopes. Space-separated string. Mutually exclusive with admin\_password. | `string` | `"openid email profile"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix to apply to resources. | `string` | n/a | yes |
| <a name="input_private_subnet_name"></a> [private\_subnet\_name](#input\_private\_subnet\_name) | GCP name of private subnet. | `string` | n/a | yes |
| <a name="input_public_facing"></a> [public\_facing](#input\_public\_facing) | If true, expose to app to public internet. | `bool` | `false` | no |
| <a name="input_redis_host"></a> [redis\_host](#input\_redis\_host) | Redis host. | `string` | n/a | yes |
| <a name="input_redis_password"></a> [redis\_password](#input\_redis\_password) | Redis password. | `string` | n/a | yes |
| <a name="input_redis_port"></a> [redis\_port](#input\_redis\_port) | Redis port. | `number` | `6379` | no |
| <a name="input_redis_server_ca_certs"></a> [redis\_server\_ca\_certs](#input\_redis\_server\_ca\_certs) | Redis server CA certs. | `string` | n/a | yes |
| <a name="input_redis_username"></a> [redis\_username](#input\_redis\_username) | Redis username. | `string` | `"default"` | no |
| <a name="input_registry_password"></a> [registry\_password](#input\_registry\_password) | Image registry password. | `string` | n/a | yes |
| <a name="input_registry_server"></a> [registry\_server](#input\_registry\_server) | Image registry server. | `string` | `"us-docker.pkg.dev/dbnlai"` | no |
| <a name="input_registry_username"></a> [registry\_username](#input\_registry\_username) | Image registry username. | `string` | n/a | yes |
| <a name="input_static_ip_name"></a> [static\_ip\_name](#input\_static\_ip\_name) | GCP _name_ of static IP reserved for ingress. | `string` | n/a | yes |
| <a name="input_terms_of_service_disabled"></a> [terms\_of\_service\_disabled](#input\_terms\_of\_service\_disabled) | Whether to disable the terms of service acceptance requirement. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dbnl_app_namespace"></a> [dbnl\_app\_namespace](#output\_dbnl\_app\_namespace) | The **computed** namespace of the application, ensuring app and necessary resources have been created |
<!-- END_TF_DOCS -->