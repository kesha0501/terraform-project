variable "location" {
  type    = string
  default = "canadacentral"
}

variable "rg_name" {
  type    = string
}

variable "subnet_id" {
  type    = string
}

variable "vm_names" {
  type    = set(string)
  default = ["n01736553-c-vm1", "n01736553-c-vm2", "n01736553-c-vm3"]
}

variable "vm_username" {
  type    = string
  default = "n01736553"
}

variable "vm_public_key" {
  type    = string
  default = "/home/n01736553/.ssh/id_rsa.pub"
}

variable "vm_private_key" {
  type    = string
  default = "/home/n01736553/.ssh/id_rsa"
}

variable "sa_name" {
  type    = string
}
