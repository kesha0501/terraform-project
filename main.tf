module "resource_group" {
  source   = "./modules/rgroup-n01736553"
  location = var.location
}

module "network" {
  source   = "./modules/network-n01736553"
  location = var.location
  rg_name  = module.resource_group.rg_name
}

module "common" {
  source   = "./modules/common-n01736553"
  location = var.location
  rg_name  = module.resource_group.rg_name
}

module "linux_vms" {
  source      = "./modules/vmlinux-n01736553"
  location    = var.location
  rg_name     = module.resource_group.rg_name
  subnet_id   = module.network.subnet_id
  vm_names    = ["n01736553-c-vm1", "n01736553-c-vm2", "n01736553-c-vm3"]
  vm_username = var.vm_username
  sa_name     = module.common.sa_name
}

module "windows_vms" {
  source      = "./modules/vmwindows-n01736553"
  location    = var.location
  rg_name     = module.resource_group.rg_name
  subnet_id   = module.network.subnet_id
  sa_name     = module.common.sa_name
  vm_names    = ["n01736553-c-vm0"]
  vm_username = var.vm_username
  vm_password = var.vm_password
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "canadacentral"
}

variable "vm_username" {
  description = "Admin username for the VMs"
  type        = string
  sensitive   = true
}

variable "vm_password" {
  description = "Admin password for the VMs"
  type        = string
  sensitive   = true
}
