<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db"></a> [db](#module\_db) | terraform-google-modules/sql-db/google//modules/postgresql | ~> 20.1 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Name of the database | `string` | `"dbnl"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Database instance type attributes | `map(string)` | n/a | yes |
| <a name="input_network_url"></a> [network\_url](#input\_network\_url) | URL of the network the DB can connect to | `string` | n/a | yes |
| <a name="input_password"></a> [password](#input\_password) | Password for the database | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all resources | `string` | n/a | yes |
| <a name="input_private_service_connection"></a> [private\_service\_connection](#input\_private\_service\_connection) | explicit dependency on PSC creation in network | `any` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | GCP project | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | `"us-central1"` | no |
| <a name="input_terraform_deletion_protection"></a> [terraform\_deletion\_protection](#input\_terraform\_deletion\_protection) | Whether or not terraform can delete the database. If set to true, terraform will not be able to delete or replace the database unless this setting is changed and applied first. | `bool` | `false` | no |
| <a name="input_username"></a> [username](#input\_username) | Username for the database | `string` | `"basic_user"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_name"></a> [database\_name](#output\_database\_name) | The name of the database |
| <a name="output_host"></a> [host](#output\_host) | The (internal) host of the database |
| <a name="output_password"></a> [password](#output\_password) | The password for the database |
| <a name="output_port"></a> [port](#output\_port) | The port of the database |
| <a name="output_username"></a> [username](#output\_username) | The username for the database |
<!-- END_TF_DOCS -->