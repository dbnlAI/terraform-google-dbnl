<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloud_nat"></a> [cloud\_nat](#module\_cloud\_nat) | terraform-google-modules/cloud-nat/google | ~> 5.0 |
| <a name="module_static_ip"></a> [static\_ip](#module\_static\_ip) | terraform-google-modules/address/google | ~> 3.1 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google | ~> 9.1 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_global_address.vpc_peering](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_global_address) | resource |
| [google-beta_google_compute_managed_ssl_certificate.ingress_cert](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_managed_ssl_certificate) | resource |
| [google-beta_google_compute_ssl_certificate.ingress_cert](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_ssl_certificate) | resource |
| [google-beta_google_service_networking_connection.private_service_connection](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_service_networking_connection) | resource |
| [google_project_service.service_networking_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [random_pet.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [google_compute_address.static_ip](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_address) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | Domain name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix to apply to named resources. | `string` | n/a | yes |
| <a name="input_private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | Private subnet cidr. | `string` | `"10.0.0.0/24"` | no |
| <a name="input_project"></a> [project](#input\_project) | GCP project. | `string` | n/a | yes |
| <a name="input_public_facing"></a> [public\_facing](#input\_public\_facing) | Is this environment public facing? | `bool` | n/a | yes |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | Public subnet cidr. | `string` | `"10.0.1.0/24"` | no |
| <a name="input_region"></a> [region](#input\_region) | GCP region. | `string` | `"us-central1"` | no |
| <a name="input_tls_cert"></a> [tls\_cert](#input\_tls\_cert) | TLS certificate, if providing your own. WARNING: this will be stored in plaintext in the state file. | `string` | `null` | no |
| <a name="input_tls_key"></a> [tls\_key](#input\_tls\_key) | TLS key, if providing your own. WARNING: this will be stored in plaintext in the state file. | `string` | `null` | no |
| <a name="input_user_provided_static_ip_name"></a> [user\_provided\_static\_ip\_name](#input\_user\_provided\_static\_ip\_name) | GCP name of Static IP Resource if it has already been reserved. This allows you to pre-register the A Record in your DNS provider for the GKE Load Balancer. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ingress_cert_name"></a> [ingress\_cert\_name](#output\_ingress\_cert\_name) | Name of the certificate resource |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | GCP name of the network |
| <a name="output_network_url"></a> [network\_url](#output\_network\_url) | GCP (internal) URL of the network |
| <a name="output_private_service_connection"></a> [private\_service\_connection](#output\_private\_service\_connection) | GCP private service connection for connecting to DB/Redis |
| <a name="output_private_subnet_name"></a> [private\_subnet\_name](#output\_private\_subnet\_name) | GCP name of the private subnet |
| <a name="output_static_ip"></a> [static\_ip](#output\_static\_ip) | Static IP address, used for Kubernetes Ingress |
| <a name="output_static_ip_name"></a> [static\_ip\_name](#output\_static\_ip\_name) | GCP name of Static IP, used for Kubernetes Ingress |
<!-- END_TF_DOCS -->