resource "azurerm_availability_set" "avset" {
  name                = "n01736553-w-avset"
  location            = var.location
  resource_group_name = var.rg_name
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_public_ip" "vm_pip" {
  count               = length(var.vm_names)
  name                = "${var.vm_names[count.index]}-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "${lower(replace(var.vm_names[count.index], "-", ""))}"
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_network_interface" "vm_nic" {
  count               = length(var.vm_names)
  name                = "${var.vm_names[count.index]}-nic"
  location            = var.location
  resource_group_name = var.rg_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_pip[count.index].id
  }
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  count               = length(var.vm_names)
  name                = var.vm_names[count.index]
  location            = var.location
  resource_group_name = var.rg_name
  size = "Standard_B1ms"
  admin_username      = var.vm_username
  admin_password      = var.vm_password
  network_interface_ids = [azurerm_network_interface.vm_nic[count.index].id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  boot_diagnostics {
    storage_account_uri = "https://${var.sa_name}.blob.core.windows.net/"
  }
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count                = length(var.vm_names)
  name                 = "IaaSAntimalware"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm[count.index].id
  publisher            = "Microsoft.Azure.Security"
  type                 = "IaaSAntimalware"
  type_handler_version = "1.3"
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}
resource "azurerm_virtual_machine_extension" "network_watcher" {
  count                = length(var.vm_names)
  name                 = "NetworkWatcherAgentWindows"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm[count.index].id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentWindows"
  type_handler_version = "1.4"
  automatic_upgrade_enabled = true
  settings = jsonencode({
    "provisioningState" = "Succeeded"
  })  
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  count                = length(var.vm_names)
  name                 = "AzureMonitorWindowsAgent"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm[count.index].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorWindowsAgent"
  type_handler_version = "1.13" 
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}
