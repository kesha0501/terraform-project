output "vm_hostnames" {
  value = [for vm in azurerm_windows_virtual_machine.vm : vm.name]
}

output "vm_fqdns" {
  value = [for pip in azurerm_public_ip.vm_pip : pip.fqdn]
}

output "vm_private_ips" {
  value = [for nic in azurerm_network_interface.vm_nic : nic.ip_configuration[0].private_ip_address]
}

output "vm_public_ips" {
  value = [for pip in azurerm_public_ip.vm_pip : pip.ip_address]
}
