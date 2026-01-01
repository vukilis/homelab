output "id" {
    description = "The Proxmox VMID of the container"
    value       = proxmox_lxc.container.vmid
}

output "hostname" {
    description = "The hostname of the container"
    value       = proxmox_lxc.container.hostname
}

output "ip_address" {
    description = "The primary IP address of the container (eth0)"
    value       = proxmox_lxc.container.network[0].ip
}

output "status" {
    description = "The running status of the LXC"
    value       = proxmox_lxc.container.start
}