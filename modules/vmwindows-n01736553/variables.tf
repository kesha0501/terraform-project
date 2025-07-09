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
  type    = list(string)
  default = ["n01736553-w-vm1"]
}

variable "vm_username" {
  type    = string
  default = "n01736553"
}

variable "vm_password" {
  type    = string
  default = "Winadm123"
}

variable "sa_name" {
  type    = string
}
