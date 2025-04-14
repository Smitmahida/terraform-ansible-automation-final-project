
variable "prefix" {
  default = "9207"
}

variable "location" {
  default = "canadacentral"
}

variable "vm_size" {
  default = "Standard_B1s"
}

variable "admin_username" {
  default = "n01699207"
}

variable "admin_password" {}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "ssh_private_key" {
  default = "~/.ssh/id_rsa"
}

