
output "linux_vms_info" {
  value = module.linux_vms.linux_vm_ips
}

output "windows_vm_info" {
  value = module.windows_vm.windows_vm_ip
}

