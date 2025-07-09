resource "azurerm_availability_set" "avset" {
  name                = "n01736553-avset"
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
  for_each            = var.vm_names
  name                = "${each.value}-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "${lower(replace(each.value, "-", ""))}"
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_network_interface" "vm_nic" {
  for_each            = var.vm_names
  name                = "${each.value}-nic"
  location            = var.location
  resource_group_name = var.rg_name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_pip[each.value].id
  }
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = var.vm_names
  name                = each.value
  location            = var.location
  resource_group_name = var.rg_name
  size = "Standard_B1ms"
  admin_username      = var.vm_username
  network_interface_ids = [azurerm_network_interface.vm_nic[each.value].id]
  admin_ssh_key {
    username   = var.vm_username
    public_key = file(var.vm_public_key)
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_4-gen2"
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

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each = var.vm_names
  name                 = "NetworkWatcherAgentLinux"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm[each.value].id
  publisher            = "Microsoft.Azure.NetworkWatcher"
  type                 = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each = var.vm_names
  name                 = "AzureMonitorLinuxAgent"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm[each.value].id
  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.31"
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "n01736553"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "null_resource" "display_hostname" {
  for_each = var.vm_names
  provisioner "remote-exec" {
    inline = ["echo ${each.value}"]
    connection {
      type        = "ssh"
      user        = var.vm_username
      private_key = file(var.vm_private_key)
      host        = azurerm_public_ip.vm_pip[each.value].ip_address
    }
  }
}
