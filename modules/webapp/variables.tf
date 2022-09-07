variable "resource_group_name" {
  type        = string
  description = "resource  group name"
}
variable "location" {
  type        = string
  description = "Location of the resource group"
}

variable "azurerm_app_service_plan_name" {
  type        = string
  description = "azure app service plan name"
}

variable "azurerm_app_service_name" {
  type        = string
  description = "azure app service name"
}

variable "azure_postgresql_name" {
  type        = string
  description = "name of  the azure postgresql server"
}

variable "administrator_login" {
  type        = string
  description = "administratorlogin"
}

variable "administrator_login_password" {
  type        = string
  description = "administratorlogin"
}

variable "azurerm_postgresql_database_name" {
  type        = string
  description = "azurerm_postgresql_database_name"
}

variable "cms_subnet_id" {
  type        = string
  description = "cms_subnet_id"
}
