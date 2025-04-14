output "private_ips" {
  value = {
    for name, nic in azurerm_network_interface.linux_nic :
    name => nic.ip_configuration[0].private_ip_address
  }
}

output "vm_public_ips" {
  value = {
    for name, pip in azurerm_public_ip.vm_public_ip :
    name => pip.ip_address
  }
}

