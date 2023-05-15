resource "proxmox_virtual_environment_file" "debian_cloud_image" {
  content_type = "iso"
  datastore_id = "local-lvm"
  node_name    = var.node_name_1

  source_file {
    path      = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
    file_name = "jammy-server-cloudimg-amd64.img"
    #  checksum  = "0944d9163e6b03100d21931dc9d8ba2e4304a6a471cf1db02869f022a65559b8"
  }
}

resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local-lvm"
  node_name    = var.node_name_1

  source_raw {
    data = <<EOF
#cloud-config
package_upgrade: true
packages:
  - qemu-guest-agent

timezone: America/Los_Angeles
users:
  - name: linuxuser
    passwd: linuxpassword
    groups: [adm, cdrom, dip, plugdev, render, lxd, sudo]
    lock_passwd: false
    sudo: ALL=(ALL) NOPASSWD:ALL
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa HFLKSDHFSDHFSDKLJNNFSDorsomething

power_state:
    delay: now
    mode: reboot
    message: Rebooting after cloud-init completion
    condition: true
EOF

    file_name = "user-data.yml"
  }
}
