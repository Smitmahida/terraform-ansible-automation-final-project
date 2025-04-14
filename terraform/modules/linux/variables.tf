variable "prefix" {}
variable "location" {}
variable "resource_group" {}
variable "subnet_id" {}
variable "vm_size" {}
variable "admin_username" {}
variable "ssh_public_key" {}
variable "image" {}
variable "vm_count" {
  default = 2
}

