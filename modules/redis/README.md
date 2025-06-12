<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_redis"></a> [redis](#module\_redis) | terraform-google-modules/memorystore/google | ~> 9.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_memory_size_gb"></a> [memory\_size\_gb](#input\_memory\_size\_gb) | Redis memory size in GB | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of authorized network | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all resources | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | GCP project | `string` | n/a | yes |
| <a name="input_redis_subnet_cidr"></a> [redis\_subnet\_cidr](#input\_redis\_subnet\_cidr) | Subnet cidr | `string` | `"10.0.2.0/24"` | no |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | `"us-central1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_host"></a> [host](#output\_host) | Redis instance host |
| <a name="output_password"></a> [password](#output\_password) | Redis instance password |
| <a name="output_port"></a> [port](#output\_port) | Redis instance port |
| <a name="output_server_ca_certs"></a> [server\_ca\_certs](#output\_server\_ca\_certs) | Redis instance server CA certificates |
| <a name="output_username"></a> [username](#output\_username) | Redis instance username |
<!-- END_TF_DOCS -->