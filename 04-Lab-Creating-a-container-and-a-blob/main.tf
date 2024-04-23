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

# Here we are creating a storage account.
# The storage account service has more properties and hence there are more arguements we can specify here

resource "azurerm_storage_account" "storage_account" {
  name                     = "terraformstore10090"
  resource_group_name      = "app-grp"
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}

# Here we are creating a container in the storage account
resource "azurerm_storage_container" "data" {
  name                 = "data"
  storage_account_name = "terraformstore10090"
  #container_access_type = "private"
  container_access_type = "blob"
}

# This is used to upload a local file onto the container
resource "azurerm_storage_blob" "sample" {
  name                   = "sample.txt"
  storage_account_name   = "appstore4577687"
  storage_container_name = "data"
  type                   = "Block"
  source                 = "sample.txt"
}
