
resource "azurerm_postgresql_server" "postgresql" {
  name                         = var.azure_postgresql_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password

  sku_name   = "GP_Gen5_4"
  version    = "11"
  storage_mb = 640000

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled = false
  ssl_enforcement_enabled       = false
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"
}

resource "azurerm_postgresql_database" "postgresdb" {
  name                = var.azurerm_postgresql_database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgresql.name
  charset             = "UTF8"
  collation           = "English_United States.1252"
}


resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.azurerm_private_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_link" {
  name                  = "private_dns_link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = var.virtual_network_id
  registration_enabled  = true
}

resource "azurerm_private_endpoint" "sql_postgres" {
  name                = var.postgresql_private_endpoint
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.data_subnet_id

  private_service_connection {
    name                           = var.postgresql_private_link
    private_connection_resource_id = azurerm_postgresql_server.postgresql.id
    subresource_names              = ["postgresqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                  = "dns-group"
    private_dns_zone_ids  = [ azurerm_private_dns_zone.private_dns_zone.id ]
  }
} 