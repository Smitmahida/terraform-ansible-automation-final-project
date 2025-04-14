resource "null_resource" "ansible_provision" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ../../ansible/inventory.ini ../../ansible/9207-playbook.yml"
  }
}
