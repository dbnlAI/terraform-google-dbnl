# terraform-google-dbnl

Terraform modules to deploy dbnl in GCP

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 5.30 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~>5 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.5 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.23 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 5.30 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app"></a> [app](#module\_app) | ./modules/app | n/a |
| <a name="module_blobstore"></a> [blobstore](#module\_blobstore) | ./modules/blobstore | n/a |
| <a name="module_database"></a> [database](#module\_database) | ./modules/database | n/a |
| <a name="module_iam"></a> [iam](#module\_iam) | ./modules/iam | n/a |
| <a name="module_kubernetes"></a> [kubernetes](#module\_kubernetes) | ./modules/kubernetes | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_redis"></a> [redis](#module\_redis) | ./modules/redis | n/a |

## Resources

| Name | Type |
|------|------|
| [google_client_config.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |
| [google_project.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Admin password. Mutually exclusive with OIDC settings | `string` | `null` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Database password. | `string` | n/a | yes |
| <a name="input_desired_size"></a> [desired\_size](#input\_desired\_size) | Desired number of GKE nodes. | `number` | `1` | no |
| <a name="input_dev_token_private_key"></a> [dev\_token\_private\_key](#input\_dev\_token\_private\_key) | Private key used to sign dev tokens. | `string` | `""` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | App domain name. | `string` | n/a | yes |
| <a name="input_flower_basic_auth_password"></a> [flower\_basic\_auth\_password](#input\_flower\_basic\_auth\_password) | Flower basic auth password for UI access. | `string` | `null` | no |
| <a name="input_flower_basic_auth_username"></a> [flower\_basic\_auth\_username](#input\_flower\_basic\_auth\_username) | Flower basic auth username for UI access. | `string` | `null` | no |
| <a name="input_flower_enabled"></a> [flower\_enabled](#input\_flower\_enabled) | Whether to enable Flower monitoring for Celery queues. | `bool` | `false` | no |
| <a name="input_helm_chart_version"></a> [helm\_chart\_version](#input\_helm\_chart\_version) | Helm Chart version. | `string` | n/a | yes |
| <a name="input_helm_release_name"></a> [helm\_release\_name](#input\_helm\_release\_name) | Helm Release name. | `string` | `"dbnl"` | no |
| <a name="input_helm_release_namespace"></a> [helm\_release\_namespace](#input\_helm\_release\_namespace) | Namespace for helm release. | `string` | `"default"` | no |
| <a name="input_helm_repository_password"></a> [helm\_repository\_password](#input\_helm\_repository\_password) | Password for accessing helm chart repository. If unset, defaults to `registry_password` | `string` | `null` | no |
| <a name="input_helm_repository_url"></a> [helm\_repository\_url](#input\_helm\_repository\_url) | URL for accessing helm chart repository. | `string` | `"oci://us-docker.pkg.dev/dbnlai/dbnl"` | no |
| <a name="input_helm_repository_username"></a> [helm\_repository\_username](#input\_helm\_repository\_username) | Username for accessing helm chart repository. | `string` | `"_json_key_base64"` | no |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | App instance size. | `string` | n/a | yes |
| <a name="input_oidc_audience"></a> [oidc\_audience](#input\_oidc\_audience) | OIDC audience. Mutually exclusive with admin\_password. | `string` | `null` | no |
| <a name="input_oidc_client_id"></a> [oidc\_client\_id](#input\_oidc\_client\_id) | OIDC client id. Mutually exclusive with admin\_password. | `string` | `null` | no |
| <a name="input_oidc_issuer"></a> [oidc\_issuer](#input\_oidc\_issuer) | OIDC issuer. Mutually exclusive with admin\_password. | `string` | `null` | no |
| <a name="input_oidc_scopes"></a> [oidc\_scopes](#input\_oidc\_scopes) | OIDC scopes. Space-separated string. Mutually exclusive with admin\_password. | `string` | `"openid email profile"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix to apply to resources. | `string` | n/a | yes |
| <a name="input_public_facing"></a> [public\_facing](#input\_public\_facing) | Whether the app is public facing. | `bool` | `false` | no |
| <a name="input_registry_password"></a> [registry\_password](#input\_registry\_password) | Image registry password. | `string` | n/a | yes |
| <a name="input_registry_server"></a> [registry\_server](#input\_registry\_server) | Image registry server. | `string` | `"us-docker.pkg.dev/dbnlai"` | no |
| <a name="input_registry_username"></a> [registry\_username](#input\_registry\_username) | Image registry username. | `string` | `"_json_key_base64"` | no |
| <a name="input_terms_of_service_disabled"></a> [terms\_of\_service\_disabled](#input\_terms\_of\_service\_disabled) | Whether to disable the terms of service acceptance requirement. | `bool` | `false` | no |
| <a name="input_terraform_deletion_protection"></a> [terraform\_deletion\_protection](#input\_terraform\_deletion\_protection) | Whether or not terraform can delete resources such as database and kubernetes cluster. If set to true, terraform will not be able to delete or replace these resources. | `bool` | `false` | no |
| <a name="input_tls_cert"></a> [tls\_cert](#input\_tls\_cert) | TLS certificate, if providing your own. Will be stored as Kubernetes secret. | `string` | `null` | no |
| <a name="input_tls_key"></a> [tls\_key](#input\_tls\_key) | TLS key, if providing your own. Will be stored as Kubernetes secret. | `string` | `null` | no |
| <a name="input_user_provided_static_ip_name"></a> [user\_provided\_static\_ip\_name](#input\_user\_provided\_static\_ip\_name) | GCP name of Static IP Resource if it has already been reserved. This allows you to pre-register the A Record in your DNS provider for the GKE Load Balancer. | `string` | `null` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR. | `string` | `"192.168.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | Kubernetes cluster CA certificate |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Kubernetes cluster endpoint |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Kubernetes cluster name |
| <a name="output_load_balancer_name"></a> [load\_balancer\_name](#output\_load\_balancer\_name) | GCP name of the load balancer |
| <a name="output_load_balancer_static_ip"></a> [load\_balancer\_static\_ip](#output\_load\_balancer\_static\_ip) | Static IP address for the load balancer |
<!-- END_TF_DOCS -->