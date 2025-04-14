resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-controlnic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_public_ip" "pip" {
  name                = "${var.prefix}-controlpip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Static"
}

resource "azurerm_linux_virtual_machine" "control_node" {
  name                  = "${var.prefix}-control"
  location              = var.location
  resource_group_name   = var.resource_group
  network_interface_ids = [azurerm_network_interface.nic.id]
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
    sku       = "8_2"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

#  provisioner "remote-exec" {
#   inline = [
#     "sudo dnf install -y epel-release",
#     "sudo dnf install -y ansible"
#   ]
#
#    connection {
#      type        = "ssh"
#      user        = var.admin_username
#      private_key = file(var.ssh_private_key)
#      host        = azurerm_public_ip.pip.ip_address
#    }
#  }

  tags = {
    Role = "ControlNode"
  }
}
