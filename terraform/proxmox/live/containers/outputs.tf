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
            "alpine-it-tools"  = try(module.alpine-it-tools, null)
            "komodo"           = try(module.komodo, null)
            "homepage"         = try(module.homepage, null)
            "uptime-kuma"      = try(module.uptime-kuma, null)
            "medusa"           = try(module.medusa, null)
            "usememos"         = try(module.usememos, null)
            "wallos"           = try(module.wallos, null)
            "watchyourlan"     = try(module.watchyourlan, null)
            "traccar"          = try(module.traccar, null)
            "jetlog"           = try(module.jetlog, null)
            "twingate"         = try(module.twingate, null)
            "grafana"          = try(module.grafana, null)  
            "beszel"           = try(module.beszel, null)  
            "mealie"           = try(module.mealie, null)  
            "linkstack"        = try(module.linkstack, null)  
            "dozzle"           = try(module.dozzle, null)  
            "speedtest"        = try(module.speedtest, null)  
            "whatsupdocker"    = try(module.whatsupdocker, null)  
            "wikidocs"         = try(module.wikidocs, null)  
            "yaade"            = try(module.yaade, null)  
            
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