resource "azurerm_service_plan" "azureappserviceplan" {
  name                = var.azurerm_app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Windows"
  sku_name            = "P1v2"
}


resource "azurerm_windows_web_app" "webapp" {
  name                = var.azurerm_app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.azureappserviceplan.id
  
  
  https_only            = true

  site_config { 
    minimum_tls_version = "1.2"
    managed_pipeline_mode     = "Integrated"
    use_32_bit_worker         = true

    application_stack{
      current_stack             ="dotnet"
      dotnet_version  = "v4.0"
  }
  }

  # Do not attach Storage by default
  app_settings = {
    # WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    Host                             = "${var.azure_postgresql_name}.postgres.database.azure.com"
    User                             = "${var.administrator_login}@${var.azure_postgresql_name}"
    DBname                           = var.azurerm_postgresql_database_name
    Port                             = "5432"
    Password                         = var.administrator_login_password
  }
}


#  Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_windows_web_app.webapp.id
  repo_url           = "https://github.com/pathikrawalapm/WebAppSample.git"
  branch             = "main"
  use_manual_integration = true
  use_mercurial      = false

/*
  github_action_configuration{
    code_configuration{
      runtime_stack = ".NET"
      runtime_version ="v4.0"
    }
  }
  */
}

resource "azurerm_app_service_virtual_network_swift_connection" "app_Service_vnet_connection" {
  app_service_id = azurerm_windows_web_app.webapp.id
  subnet_id      = var.cms_subnet_id
}
