terraform {
  backend "azurerm" {
    resource_group_name  = "n01699207-RG"
    storage_account_name = "n01699207storage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
