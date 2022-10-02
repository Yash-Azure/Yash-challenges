terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.5.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "tfstatewerfc23"
    container_name       = "tfstate-container"
    key                  = "demo.tfstate"
  }
}

provider "azuread" {
  use_msi   = true
  tenant_id = var.tenant_id
}

provider "azurerm" {
  use_msi         = true
  tenant_id       = var.tenant_id
  subscription_id = local.subid
  features {}
}