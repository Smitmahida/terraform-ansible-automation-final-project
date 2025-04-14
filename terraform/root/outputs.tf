output "vm_private_ips" {
  value = module.vm.private_ips
}

output "load_balancer_ip" {
  description = "Public IP address of the load balancer"
  value       = module.loadbalancer.lb_ip
}

output "vm_public_ips" {
  value = module.vm.vm_public_ips
}

