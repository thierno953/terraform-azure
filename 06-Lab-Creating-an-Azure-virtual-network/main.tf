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

resource "azurerm_virtual_network" "app_network" {
  name                = "app-network"
  location            = local.location
  resource_group_name = azurerm_resource_group.app_grp.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "subnetA"
    address_prefix = "10.0.1.0/24"
  }
}
