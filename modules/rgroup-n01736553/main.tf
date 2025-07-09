resource "azurerm_resource_group" "rg" {
  name     = "n01736553RG"
  location = var.location
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}
