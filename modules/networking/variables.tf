variable "virtual_network_name" {
  type        = string
  description = "name of the virtual network"
}
variable "resource_group_name" {
  type        = string
  description = "resource group name"
}
variable "virtual_network_address_space" {
  type        = list(string)
  description = "address space of the virtual network"
}
variable "location" {
  type        = string
  description = "location of the virtual network"
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
