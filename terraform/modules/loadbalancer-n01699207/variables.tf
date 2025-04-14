variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "vm_names" {
  type = list(string)
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

