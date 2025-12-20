output "container_ip" {
    description = "The IPv4 address of the container"
    value       = proxmox_lxc.container.network[0].ip
}