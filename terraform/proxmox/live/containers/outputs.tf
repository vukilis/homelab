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
            "filebrowser"      = try(module.filebrowser, null)  
            "netalertx"        = try(module.netalertx, null)  
            "smokeping"        = try(module.smokeping, null)  
            "gotify"           = try(module.gotify, null)  
            "turnkey-fileserver" = try(module.turnkey-fileserver, null)  
            "navidrome"        = try(module.navidrome, null)  
            "semaphore"        = try(module.semaphore, null)  
            
            "test-container-0" = try(module.test-container-0, null)
            "test-container-1" = try(module.test-container-1, null)
        } : name => {
            id   = try(data.vmid, "Not in state")
            ip   = try(data.ip_address, "Not in state")
            name = try(data.hostname, "Not in state")
        } if data != null
    }
}