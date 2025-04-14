variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "vm_names" {
  type = list(string)
}

variable "admin_username" {
  type    = string
  default = "azureadmin"
}

variable "tags" {
  type = map(string)
}

variable "subnet_id" {
  description = "Subnet ID to assign to VM NICs"
  type        = string
}

variable "backend_address_pool_id" {
  description = "ID of the load balancer's backend address pool"
  type        = string
}

variable "vm_prefix" {
  description = "Prefix to use for naming resources like availability set"
  type        = string
}
