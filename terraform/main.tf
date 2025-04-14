terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

module "rgroup" {
  source  = "./modules/rgroup"
  prefix  = var.prefix
  location = var.location
}

module "network" {
  source          = "./modules/network"
  prefix          = var.prefix
  location        = var.location
  resource_group  = module.rgroup.name
}

module "linux_vms" {
  source           = "./modules/linux"
  prefix           = var.prefix
  location         = var.location
  resource_group   = module.rgroup.name
  subnet_id        = module.network.subnet_id
  vm_size          = var.vm_size
  admin_username   = var.admin_username
  ssh_public_key   = var.ssh_public_key
  image            = "8_2"
  vm_count         = 2
}

module "windows_vm" {
  source           = "./modules/windows"
  prefix           = var.prefix
  location         = var.location
  resource_group   = module.rgroup.name
  subnet_id        = module.network.subnet_id
  vm_size          = var.vm_size
  admin_username   = var.admin_username
  admin_password   = var.admin_password
  image            = "2019-Datacenter"
}

