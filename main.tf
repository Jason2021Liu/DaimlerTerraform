terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }

  backend "azurerm" {
    resource_group_name = "daimlerdev"
    storage_account_name = "daimlerst"
    container_name = "tfstate"
    key = "boBQYoF4erjMFhDnUwVIKGFhMWfHR1leAOfknrVX2Fg9bHfTbTeA3RVZNw6ST7XMZmaJwxJ5999p1Y+LPPGDPQ=="
  }
}

provider "azurerm" {
  features {}
}



