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

variable "storage_account_name" {
  type        = string
  description = "Please enter the storage account name"
}

locals {
  resource_group = "app-grp"
  location       = "West Europe"
}

resource "azurerm_resource_group" "app_grp" {
  name     = local.resource_group
  location = local.location
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = local.resource_group
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true

  depends_on = [azurerm_resource_group.app_grp]
}

resource "azurerm_storage_container" "data" {
  name                 = "data"
  storage_account_name = var.storage_account_name
  container_access_type = "blob"

  depends_on = [azurerm_storage_account.storage_account]
}

resource "azurerm_storage_blob" "sample" {
  name                   = "sample.txt"
  storage_account_name   = var.storage_account_name
  storage_container_name = "data"
  type                   = "Block"
  source                 = "sample.txt"

  depends_on = [azurerm_storage_container.data]

}
