data "azurerm_client_config" "current" {}
 
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
 
resource "azurerm_storage_account" "storageaccount" {
  name                     = "rgcontososales"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

module "virtual-network" {
  source                        = "./modules/networking"
  virtual_network_name          = var.virtual_network_name
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  virtual_network_address_space = var.virtual_network_address_space
  cms_subnet_name               = var.cms_subnet_name
  data_subnet_name              = var.data_subnet_name
  cms_subnet_address_prefix     = var.cms_subnet_address_prefix
  data_subnet_address_prefix    = var.data_subnet_address_prefix
}


module "keyvault" {
  source              = "./modules/keyvault"
  name                = var.key_vault_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  enabled_for_deployment          = var.kv-vm-deployment
  enabled_for_disk_encryption     = var.kv-disk-encryption
  enabled_for_template_deployment = var.kv-template-deployment
  tags = {
    environment = "dev"
  }


  secrets = var.kv-secrets
}

# Generate Password
resource "random_password" "postgres_administrator_login_password" {
  length           = 24
  special          = true
  override_special = "_%@"
}

module "webapp" {
  source                                  = "./modules/webapp"
  resource_group_name                     = azurerm_resource_group.rg.name
  location                                = azurerm_resource_group.rg.location
  azurerm_app_service_plan_name           = var.azurerm_app_service_plan_name
  azurerm_app_service_name                = var.azurerm_app_service_name
  administrator_login                     = var.administrator_login
  administrator_login_password            = random_password.postgres_administrator_login_password.result
  azure_postgresql_name                   = var.azure_postgresql_name
  azurerm_postgresql_database_name        = var.azurerm_postgresql_database_name
  cms_subnet_id                           = module.virtual-network.cmssubnet_id
}

module "postgresql" {
  source                           = "./modules/postgres"
  azure_postgresql_name            = var.azure_postgresql_name
  resource_group_name              = azurerm_resource_group.rg.name
  location                         = azurerm_resource_group.rg.location
  administrator_login              = var.administrator_login
  administrator_login_password     = random_password.postgres_administrator_login_password.result
  data_subnet_id                   = module.virtual-network.datasubnet_id
  azurerm_postgresql_database_name = var.azurerm_postgresql_database_name
  virtual_network_id               = module.virtual-network.vnet_id
  postgresql_private_endpoint      = var.postgresql_private_endpoint
  postgresql_private_link          = var.postgresql_private_link
  azurerm_private_dns_zone_name    = var.azurerm_private_dns_zone_name
}


resource "azurerm_key_vault_secret" "postgres_administrator_login_password" {
  name         = "postgres-administrator-login-password-New"
  value        = random_password.postgres_administrator_login_password.result
  key_vault_id = module.keyvault.key-vault-id
}

resource "azurerm_key_vault_secret" "postgres_administrator_login" {
  name         = "postgres-administrator-login-New"
  value        = var.administrator_login
  key_vault_id = module.keyvault.key-vault-id
}