variable "resource_group_name" {
  type        = string
  description = "resource group name"
}
variable "location" {
  type        = string
  description = "Location of the resource group"
}


variable "azure_postgresql_name" {
  type        = string
  description = "name of the azure postgresql server"
}

variable "administrator_login" {
  type        = string
  description = "administratorlogin"
}

variable "administrator_login_password" {
  type        = string
  description = "administratorlogin"
}


variable "data_subnet_id" {
  type        = string
  description = "datasubnet_id"
}

variable "azurerm_postgresql_database_name" {
  type        = string
  description = "azurerm_postgresql_database_name"
}

variable "azurerm_private_dns_zone_name" {
  type        = string
  description = "azurerm_private_dns_zone_name"
}

variable "postgresql_private_endpoint" {
  type        = string
  description = "postgresql_private_endpoint"
}


variable "virtual_network_id" {
  type        = string
  description = "Id  of the virtual network"
}



variable "postgresql_private_link" {
  type        = string
  description = "postgresql_private_link"
}
