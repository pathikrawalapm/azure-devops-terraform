# networking

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.cmssubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.datasubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cms_subnet_address_prefix"></a> [cms\_subnet\_address\_prefix](#input\_cms\_subnet\_address\_prefix) | address prefix of the subnet | `string` | n/a | yes |
| <a name="input_cms_subnet_name"></a> [cms\_subnet\_name](#input\_cms\_subnet\_name) | name of the subnet | `string` | n/a | yes |
| <a name="input_data_subnet_address_prefix"></a> [data\_subnet\_address\_prefix](#input\_data\_subnet\_address\_prefix) | address prefix of the subnet | `string` | n/a | yes |
| <a name="input_data_subnet_name"></a> [data\_subnet\_name](#input\_data\_subnet\_name) | name of the subnet | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | location of the virtual network | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | resource group name | `string` | n/a | yes |
| <a name="input_virtual_network_address_space"></a> [virtual\_network\_address\_space](#input\_virtual\_network\_address\_space) | address space of the virtual network | `list(string)` | n/a | yes |
| <a name="input_virtual_network_name"></a> [virtual\_network\_name](#input\_virtual\_network\_name) | name of the virtual network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cmssubnet_id"></a> [cmssubnet\_id](#output\_cmssubnet\_id) | id of the subnet |
| <a name="output_datasubnet_id"></a> [datasubnet\_id](#output\_datasubnet\_id) | id of the subnet |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
