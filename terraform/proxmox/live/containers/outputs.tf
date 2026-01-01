output "proxmox_endpoint_url" {
    description = "The API URL used to connect to Proxmox"
    value       = var.proxmox_api_url
}

output "all_containers" {
    value = {
        for name, data in {
            "dockge"           = try(module.dockge, null)
            "n8n"              = try(module.n8n, null)
            "stremio"          = try(module.stremio, null)
            "alpine-it-tools"  = try(module.alpine_it_tools, null)
            "test-container-0" = try(module.test-container-0, null)
            "test-container-1" = try(module.test-container-1, null)
        } : name => {
            id      = data != null ? data.vmid : "Module not targeted"
            ip      = data != null ? data.ip_address : "Module not targeted"
            name    = data != null ? data.hostname : "Module not targeted"
            # ip = try(tostring(data.ip_address), "Pending/Known after apply")
        }
    }
}