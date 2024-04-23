# We first specify the terraform provider. 
# Terraform will use the provider to ensure that we can work with Microsoft Azure

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Here we need to mention the Azure AD Application Object credentials to allow us to work with 
# our Azure account

provider "azurerm" {
  subscription_id = ""
  client_id       = ""
  client_secret   = ""
  tenant_id       = ""
  features {}
}

# The resource block defines the type of resource we want to work with
# The name and location are arguements for the resource block

resource "azurerm_resource_group" "app_grp" {
  name     = "app-grp"
  location = "West Europe"
}
