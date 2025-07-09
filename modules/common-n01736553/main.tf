resource "azurerm_log_analytics_workspace" "law" {
  name                = "n01736553-LAW"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_recovery_services_vault" "rsv" {
  name                = "n01736553-RSV"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_storage_account" "sa" {
  name                     = "n01736553sa2"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}
