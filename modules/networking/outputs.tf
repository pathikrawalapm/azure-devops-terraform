output "cmssubnet_id" {
  description = "id of the subnet"
  value       = azurerm_subnet.cmssubnet.id
}

output "datasubnet_id" {
  description = "id of the subnet"
  value       = azurerm_subnet.datasubnet.id
}

output "vnet_id" {
  description = "id of the subnet"
  value       = azurerm_virtual_network.vnet.id
}