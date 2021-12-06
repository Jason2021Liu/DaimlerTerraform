terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }

  backend "azurerm" {
        resource_group_name  = "tfstate"
        storage_account_name = "tfstate7000"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }

}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name = "cli-test-dev"
  location = "eastus"
}

