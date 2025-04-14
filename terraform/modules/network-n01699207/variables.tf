variable "location" {
  type        = string
  description = "Azure region"
}

variable "rg_name" {
  type        = string
  description = "Resource Group name"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}
