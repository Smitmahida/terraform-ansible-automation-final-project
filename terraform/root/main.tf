module "network" {
  source = "../modules/network-n01699207"
  location = "canadacentral"
  rg_name  = "n01699207-RG"
  tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = "smit.mahida"
    ExpirationDate = "2025-12-31"
    Environment    = "Project"
  }
}

module "storage" {
  source   = "../modules/storage-n01699207"
  location = "canadacentral"
  rg_name  = "n01699207-RG"
  tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = "smit.mahida"
    ExpirationDate = "2025-12-31"
    Environment    = "Project"
  }
}

module "vm" {
  source    = "../modules/vmlinux-n01699207"
  location  = "canadacentral"
  rg_name   = "n01699207-RG"
  vm_names  = ["vm1", "vm2", "vm3"]
  backend_address_pool_id = module.loadbalancer.backend_pool_id
  subnet_id = module.network.subnet_id
  vm_prefix = "n01699207"

  tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = "smit.mahida"
    ExpirationDate = "2025-12-31"
    Environment    = "Project"
  }
}

module "loadbalancer" {
  source    = "../modules/loadbalancer-n01699207"
  location  = "canadacentral"
  rg_name   = "n01699207-RG"
  vm_names  = ["vm1", "vm2", "vm3"]
  tags = {
    Project        = "CCGC 5502 Automation Project"
    Name           = "smit.mahida"
    ExpirationDate = "2025-12-31"
    Environment    = "Project"
  }
}

