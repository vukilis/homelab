output "proxmox_endpoint_url" {
    description = "The API URL used to connect to Proxmox"
    value       = var.proxmox_api_url
}

output "test-container-0-ip" {
    value = module.test-container-0.container_ip
}

output "test-container-1-ip" {
    value = module.test-container-1.container_ip
}