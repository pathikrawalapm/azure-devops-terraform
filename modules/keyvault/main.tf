data "azurerm_client_config" "current" {}

# Create the Azure Key Vault in the azure used by many
resource "azurerm_key_vault" "key-vault" {
  #checkov:skip=CKV_AZURE_41:Ensure that the expiration date is set on all secrets
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = var.sku_name
  purge_protection_enabled = false
  tags                     = var.tags

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  access_policy {
    tenant_id    = data.azurerm_client_config.current.tenant_id
    object_id    = data.azurerm_client_config.current.object_id

    key_permissions         = var.kv-key-permissions-full
    secret_permissions      = var.kv-secret-permissions-full
    certificate_permissions = var.kv-certificate-permissions-full
    storage_permissions     = var.kv-storage-permissions-full
  }
}


# Create a Default Azure Key Vault access policy with Admin permissions
# This policy must be kept for a proper run of the " destroy" process
resource "azurerm_key_vault_access_policy" "default_policy" {
  key_vault_id = azurerm_key_vault.key-vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = "66d6e4ec-d850-4ec1-8045-803e28465e7e"

  lifecycle {
    create_before_destroy = true
  }

  key_permissions         = var.kv-key-permissions-full
  secret_permissions      = var.kv-secret-permissions-full
  certificate_permissions = var.kv-certificate-permissions-full
  storage_permissions     = var.kv-storage-permissions-full
}



# Create a Default Azure Key Vault access policy with Admin permissions
# This policy must be kept for a proper run of the "destroy" process
/*resource "azurerm_key_vault_access_policy" "default_policy_self" {
  key_vault_id = azurerm_key_vault.key-vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = "66d6e4ec-d850-4ec1-8045-803e28465e7e"

  lifecycle {
    create_before_destroy = true
  }

  key_permissions         = var.kv-key-permissions-full
  secret_permissions      = var.kv-secret-permissions-full
  certificate_permissions = var.kv-certificate-permissions-full
  storage_permissions     = var.kv-storage-permissions-full
} */

# Generate a random password
resource "random_password" "password" {
  for_each    = var.secrets
  length      = 20
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  min_special = 2

  keepers = {
    name = each.key
  }
}

# Create an Azure Key Vault secrets 
#checkov:skip=CKV_AZURE_41:Ensure that the expiration date is set on all secrets
resource "azurerm_key_vault_secret" "secret" {
  for_each     = var.secrets
  key_vault_id = azurerm_key_vault.key-vault.id
  name         = each.key
  value        = lookup(each.value, "value") != "" ? lookup(each.value, "value") : random_password.password[each.key].result
  tags         = var.tags
  depends_on = [
    azurerm_key_vault.key-vault,
    azurerm_key_vault_access_policy.default_policy,
  ]
}
