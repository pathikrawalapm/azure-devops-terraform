terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-terraform"
    storage_account_name = "stconstososalesterraform"
    container_name       = "infrastructure"
    key                  = "infra-dev.tfstate"
  }
  required_version = ">= 1.2.7"
}
