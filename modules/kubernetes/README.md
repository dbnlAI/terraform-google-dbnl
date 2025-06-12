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
| <a name="module_kubernetes"></a> [kubernetes](#module\_kubernetes) | terraform-google-modules/kubernetes-engine/google//modules/private-cluster | ~> 31.0 |

## Resources

| Name | Type |
|------|------|
| [google_project_service.container_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_desired_size"></a> [desired\_size](#input\_desired\_size) | Desired size of GKE cluster | `number` | `1` | no |
| <a name="input_gke_version"></a> [gke\_version](#input\_gke\_version) | GKE version | `string` | `"latest"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Kubernetes node instance type | `string` | n/a | yes |
| <a name="input_kubernetes_control_plane_cidr"></a> [kubernetes\_control\_plane\_cidr](#input\_kubernetes\_control\_plane\_cidr) | private IP block for GKE. | `string` | `"10.0.3.0/28"` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of the VPC network | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for all resources | `string` | n/a | yes |
| <a name="input_private_subnet_name"></a> [private\_subnet\_name](#input\_private\_subnet\_name) | Name of the private subnet where GKE will run | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | GCP project | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | GCP region | `string` | n/a | yes |
| <a name="input_terraform_deletion_protection"></a> [terraform\_deletion\_protection](#input\_terraform\_deletion\_protection) | Whether or not terraform can delete the Kubernetes cluster. If set to true, terraform will not be able to delete or replace the cluster unless this setting is changed and applied first. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | GKE cluster CA certificate |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | GKE cluster endpoint |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | GKE cluster name |
<!-- END_TF_DOCS -->