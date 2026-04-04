output "id" {
    description = "The Proxmox VMID of the container"
    value       = try(proxmox_lxc.container.vmid, "VMID not found")
}

output "hostname" {
    description = "The hostname of the container"
    value       = try(proxmox_lxc.container.hostname, "Hostname not found")
}

output "ip_address" {
    description = "The primary IP address of the container (eth0)"
    value       = try(proxmox_lxc.container.network[0].ip, "IP not found")
}

output "status" {
    description = "The running status of the LXC"
    value       = try(proxmox_lxc.container.start, "Status not found")
}