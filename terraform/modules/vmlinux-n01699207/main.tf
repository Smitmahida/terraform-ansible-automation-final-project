resource "azurerm_availability_set" "linux_avail_set" {
  name                         = "${var.vm_prefix}-avset"
  location                     = var.location
  resource_group_name          = var.rg_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true

  tags = var.tags
}

data "azurerm_subnet" "subnet" {
  name                 = "n01699207-RG-subnet1"
  virtual_network_name = "n01699207-RG-vnet"
  resource_group_name  = var.rg_name
}

resource "azurerm_public_ip" "vm_public_ip" {
  for_each = { for name in var.vm_names : name => name if contains(["vm2", "vm3"], name) }

  name                = "${each.key}-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Basic"
  tags                = var.tags
}

resource "azurerm_network_interface" "linux_nic" {
  for_each            = toset(var.vm_names)
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = contains(["vm2", "vm3"], each.key) ? azurerm_public_ip.vm_public_ip[each.key].id : null
  }

  tags = var.tags
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_association" {
  for_each                    = toset(["vm1", "vm2", "vm3"])
  network_interface_id        = azurerm_network_interface.linux_nic[each.key].id
  ip_configuration_name       = "internal"
  backend_address_pool_id     = var.backend_address_pool_id
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each            = toset(var.vm_names)
  name                = each.key
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_B1s"
  availability_set_id = azurerm_availability_set.linux_avail_set.id
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.linux_nic[each.key].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${each.key}-osdisk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  disable_password_authentication = true
  tags                            = var.tags
}

resource "azurerm_managed_disk" "data_disk" {
  for_each             = toset(var.vm_names)
  name                 = "${each.key}-datadisk"
  location             = var.location
  resource_group_name  = var.rg_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
  tags                 = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach_disk" {
  for_each           = toset(var.vm_names)
  managed_disk_id    = azurerm_managed_disk.data_disk[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.linux_vm[each.key].id
  lun                = 0
  caching            = "ReadWrite"
}
