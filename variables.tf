variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Location of the resource group"
}

variable "virtual_network_name" {
  type        = string
  description = "name of the virtual network"
}
variable "virtual_network_address_space" {
  type        = list(string)
  description = "address space of the virtual network"
}

variable "cms_subnet_name" {
  type        = string
  description = "name of the subnet"
}
variable "data_subnet_name" {
  type        = string
  description = "name of the subnet"
}
variable "cms_subnet_address_prefix" {
  type        = string
  description = "address prefix of the subnet"
}
variable "data_subnet_address_prefix" {
  type        = string
  description = "address prefix of the subnet"
}

variable "azure_postgresql_name" {
  type        = string
  description = "name of the azure postgresql server"
}


variable "administrator_login" {
  type        = string
  description = "administratorlogin"
}

variable "azurerm_postgresql_database_name" {
  type        = string
  description = "azurerm_postgresql_database_name"
}

variable "postgre_database_port" {
  type        = string
  description = "postgre_database_port"
}

variable "azurerm_app_service_plan_name" {
  type        = string
  description = "azure app service plan name"
}

variable "azurerm_app_service_name" {
  type        = string
  description = "azure app service name"
}

variable "postgresql_private_endpoint" {
  type        = string
  description = "postgresql_private_endpoint"
}

variable "postgresql_private_link" {
  type        = string
  description = "postgresql_private_link"
}
variable "azurerm_private_dns_zone_name" {
  type        = string
  description = "azurerm_private_dns_zone_name"
}
