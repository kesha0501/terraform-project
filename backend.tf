 terraform {
    backend "azurerm" {
      resource_group_name  = "tfstaten01736553RG"
      storage_account_name = "tfstaten01736553sa"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
    }
  }
