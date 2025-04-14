variable "location" {
  type        = string
  description = "Azure region"
}

variable "rg_name" {
  type        = string
  description = "Resource Group name"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
