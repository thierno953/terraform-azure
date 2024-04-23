terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
  features {}
}

resource "azurerm_resource_group" "app_grp" {
  name     = "app-grp"
  location = "West Europe"
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "terraformstore10090"
  resource_group_name      = "app-grp"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}
