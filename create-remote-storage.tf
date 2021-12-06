terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "daimlerdev" {
  name     = "daimlerdev"
  location = "East US"
}

resource "azurerm_storage_account" "daimlerstorage" {
  name                     = "daimlerstorage"
  resource_group_name      = azurerm_resource_group.daimlerdev.name
  location                 = azurerm_resource_group.daimlerdev.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.daimlerstorage.name
  container_access_type = "blob"
}