resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = "${var.prefix}-linuxnic${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip[count.index].id
  }
}

resource "azurerm_public_ip" "pip" {
  count               = var.vm_count
  name                = "${var.prefix}-linuxpip${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  count                 = var.vm_count
  name                  = "${var.prefix}-linuxvm${count.index + 1}"
  location              = var.location
  resource_group_name   = var.resource_group
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  size                  = var.vm_size
  admin_username        = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key)
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = var.image
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
  }
}
