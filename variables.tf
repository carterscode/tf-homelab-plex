variable "virtual_environment_username" {
  default     = "root@pam"
  type        = string
  description = "The username to use when authenticating with the Proxmox Virtual Environment API."
}
variable "virtual_environment_password" {
  default     = "myproxpassword"
  type        = string
  description = "The password to use when authenticating with the Proxmox Virtual Environment API."
}
variable "virtual_environment_endpoint" {
  default = "https://192.168.256.256:8006"
}
variable "node_name_1" {
  default     = "prox_server_name"
  type        = string
  description = "The name of the Proxmox Virtual Environment node to deploy the virtual machine to."
}

variable "plex_vm_memory" {
  type    = number
  default = 8192
}

variable "plex_vm_cpu_cores" {
  type    = number
  default = 4
}

variable "plex_vm_ip_address" {
  type    = string
  default = "192.168.256.256/24"
}

variable "plex_vm_gateway" {
  type    = string
  default = "192.168.256.256"
}

variable "plex_vm_dns" {
  type    = string
  default = "192.168.256.256"
}

variable "plex_vm_domain" {
  type    = string
  default = "domain.name"
}
