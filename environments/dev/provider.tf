terraform {
  required_version = ">= 0.14"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "mono-dev-shared-rg"
    storage_account_name = "strmono"
    container_name       = "statefile"
    key                  = "hub-spoke/dev.statefile"

  }
}
provider "azurerm" {
  features {}
  subscription_id = "a0af25b9-387e-4c4e-9aa7-0904558bfa48"
}
