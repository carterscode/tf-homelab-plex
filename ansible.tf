resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 30"
  }

  depends_on = [proxmox_virtual_environment_vm.plex_server]
}

resource "local_file" "ansible_inventory" {
  filename = "./ansible/inventory.ini"
  content  = <<-EOF
[plex_server]
plex-server ansible_host=${proxmox_virtual_environment_vm.plex_server.ipv4_addresses[1][0]} ansible_user=linuxuser ansible_become=true
  EOF
  provisioner "local-exec" {
    command     = "ansible-playbook -i ./inventory.ini ./hostname.yml"
    working_dir = "ansible"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "false"
    }
  }

  provisioner "local-exec" {
    command     = "ansible-playbook -i ./inventory.ini ./kernel.yml"
    working_dir = "ansible"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "false"
    }
  }
  depends_on = [null_resource.delay]


  provisioner "local-exec" {
    command     = "ansible-playbook -i ./inventory.ini ./plex.yml"
    working_dir = "ansible"
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "false"
    }
  }
}
