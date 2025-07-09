output "rg_name" {
  value = module.resource_group.rg_name
}

output "vnet_name" {
  value = module.network.vnet_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "law_name" {
  value = module.common.law_name
}

output "rsv_name" {
  value = module.common.rsv_name
}

output "sa_name" {
  value = module.common.sa_name
}

output "linux_vm_hostnames" {
  value = module.linux_vms.vm_hostnames
}

output "linux_vm_fqdns" {
  value = module.linux_vms.vm_fqdns
}

output "linux_vm_private_ips" {
  value = module.linux_vms.vm_private_ips
}

output "linux_vm_public_ips" {
  value = module.linux_vms.vm_public_ips
}

output "windows_vm_hostnames" {
  value = module.windows_vms.vm_hostnames
}

output "windows_vm_fqdns" {
  value = module.windows_vms.vm_fqdns
}

output "windows_vm_private_ips" {
  value = module.windows_vms.vm_private_ips
}

output "windows_vm_public_ips" {
  value = module.windows_vms.vm_public_ips
}
