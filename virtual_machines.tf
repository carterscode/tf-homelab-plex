resource "proxmox_virtual_environment_vm" "plex_server" {
  name        = "plex-server"
  description = "Managed by Terraform"
  tags        = ["terraform"]
  vm_id       = 500
  node_name   = var.node_name_1

  cpu {
    cores = var.plex_vm_cpu_cores
  }

  memory {
    dedicated = var.plex_vm_memory
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_file.debian_cloud_image.id
    interface    = "scsi0"
    size         = 32
  }

  serial_device {} #

  operating_system {
    type = "l26"
  }

  vga {
    enabled = false
  }

  hostpci {
    device = "hostpci0"
    id     = "0000:00:02.0" # My Intel Integrated Graphics
    rombar = "0"
    xvga   = "1"
  }

  initialization {
    datastore_id      = "local-lvm"
    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
    dns {
      domain = var.plex_vm_domain
      server = var.plex_vm_dns
    }

    ip_config {
      ipv4 {
        address = var.plex_vm_ip_address
        gateway = var.plex_vm_gateway
      }
    }
  }
}
