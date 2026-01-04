# Production containers for homelab-vukilis node

module "alpine-it-tools" {
    source = "../../modules/proxmox_lxc"

    enable_ssh_hardening = false
    alpine_ssh_hardening = true
    pve_connection = var.pve_connection
    ssh_public_keys = file(pathexpand("~/.ssh/vuk.lekic.pub"))
    target_node     = "homelab-vukilis"
    ostemplate      = "local:vztmpl/alpine-3.21-default_20241217_amd64.tar.xz"
    start_at_boot   = true

    vmid          = 220
    root_password = var.root_password
    unprivileged  = "true"

    # Resource Allocation
    cores     = 1
    cpu_limit = 0
    cpu_units = 100
    memory    = 256
    swap      = 0
    disk_size = "1G"
    storage   = "local-lvm"

    # Network Settings
    network_name   = "eth0"
    network_bridge = "vmbr0"
    ip_address     = "192.168.0.220/24"
    gateway        = "192.168.0.1"

    # Identity & DNS
    hostname     = "alpine-it-tools"
    searchdomain = "adguard.vukilis.com"
    nameserver   = "192.168.0.202"
    tags         = ["ct", "terraform", "utilities"]

    # Other Settings
    onboot  = true
    nesting = true
    keyctl  = false
}

module "n8n" {
    source = "../../modules/proxmox_lxc"

    enable_ssh_hardening = true
    alpine_ssh_hardening = false
    pve_connection = var.pve_connection
    ssh_public_keys = file(pathexpand("~/.ssh/vuk.lekic.pub"))
    target_node     = "homelab-vukilis"
    ostemplate      = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    start_at_boot   = true

    vmid          = 229
    root_password = var.root_password
    unprivileged  = "true"

    # Resource Allocation
    cores     = 2
    cpu_limit = 0
    cpu_units = 100
    memory    = 2048
    swap      = 0
    disk_size = "10G"
    storage   = "local-lvm"

    # Network Settings
    network_name   = "eth0"
    network_bridge = "vmbr0"
    ip_address     = "192.168.0.229/24"
    gateway        = "192.168.0.1"

    # Identity & DNS
    hostname     = "n8n"
    searchdomain = "adguard.vukilis.com"
    nameserver   = "192.168.0.202"
    tags         = ["ct", "terraform", "management"]

    # Other Settings
    onboot  = true
    nesting = true
    keyctl  = false
}
module "dockge" {
    source = "../../modules/proxmox_lxc"

    enable_ssh_hardening = true
    alpine_ssh_hardening = false
    pve_connection = var.pve_connection
    ssh_public_keys = file(pathexpand("~/.ssh/vuk.lekic.pub"))
    target_node     = "homelab-vukilis"
    ostemplate      = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    start_at_boot   = true

    vmid          = 230
    root_password = var.root_password
    unprivileged  = "true"

    # Resource Allocation
    cores     = 2
    cpu_limit = 0
    cpu_units = 100
    memory    = 2048
    swap      = 0
    disk_size = "10G"
    storage   = "local-lvm"

    # Network Settings
    network_name   = "eth0"
    network_bridge = "vmbr0"
    ip_address     = "192.168.0.230/24"
    gateway        = "192.168.0.1"

    # Identity & DNS
    hostname     = "dockge"
    searchdomain = "adguard.vukilis.com"
    nameserver   = "192.168.0.202"
    tags         = ["ct", "terraform", "management"]

    # Other Settings
    onboot  = true
    nesting = true
    keyctl  = false
}
module "komodo" {
    source = "../../modules/proxmox_lxc"

    enable_ssh_hardening = true
    alpine_ssh_hardening = false
    pve_connection = var.pve_connection
    ssh_public_keys = file(pathexpand("~/.ssh/vuk.lekic.pub"))
    target_node     = "homelab-vukilis"
    ostemplate      = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    start_at_boot   = true

    vmid          = 231
    root_password = var.root_password
    unprivileged  = "true"

    # Resource Allocation
    cores     = 2
    cpu_limit = 0
    cpu_units = 100
    memory    = 2048
    swap      = 0
    disk_size = "10G"
    storage   = "local-lvm"

    # Network Settings
    network_name   = "eth0"
    network_bridge = "vmbr0"
    ip_address     = "192.168.0.231/24"
    gateway        = "192.168.0.1"

    # Identity & DNS
    hostname     = "komodo"
    searchdomain = "adguard.vukilis.com"
    nameserver   = "192.168.0.202"
    tags         = ["ct", "terraform", "management"]

    # Other Settings
    onboot  = true
    nesting = true
    keyctl  = false
}
module "homepage" {
    source = "../../modules/proxmox_lxc"

    enable_ssh_hardening = true
    alpine_ssh_hardening = false
    pve_connection = var.pve_connection
    ssh_public_keys = file(pathexpand("~/.ssh/vuk.lekic.pub"))
    target_node     = "homelab-vukilis"
    ostemplate      = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    start_at_boot   = true

    vmid          = 203
    root_password = var.root_password
    unprivileged  = "true"

    # Resource Allocation
    cores     = 2
    cpu_limit = 0
    cpu_units = 100
    memory    = 2048
    swap      = 0
    disk_size = "10G"
    storage   = "local-lvm"

    # Network Settings
    network_name   = "eth0"
    network_bridge = "vmbr0"
    ip_address     = "192.168.0.203/24"
    gateway        = "192.168.0.1"

    # Identity & DNS
    hostname     = "homepage"
    searchdomain = "adguard.vukilis.com"
    nameserver   = "192.168.0.202"
    tags         = ["ct", "terraform", "dashboard"]

    # Other Settings
    onboot  = true
    nesting = true
    keyctl  = false
}
module "uptime-kuma" {
    source = "../../modules/proxmox_lxc"

    enable_ssh_hardening = true
    alpine_ssh_hardening = false
    pve_connection = var.pve_connection
    ssh_public_keys = file(pathexpand("~/.ssh/vuk.lekic.pub"))
    target_node     = "homelab-vukilis"
    ostemplate      = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    start_at_boot   = true

    vmid          = 201
    root_password = var.root_password
    unprivileged  = "true"

    # Resource Allocation
    cores     = 1
    cpu_limit = 0
    cpu_units = 100
    memory    = 1024
    swap      = 0
    disk_size = "10G"
    storage   = "local-lvm"

    # Network Settings
    network_name   = "eth0"
    network_bridge = "vmbr0"
    ip_address     = "192.168.0.201/24"
    gateway        = "192.168.0.1"

    # Identity & DNS
    hostname     = "uptime-kuma"
    searchdomain = "adguard.vukilis.com"
    nameserver   = "192.168.0.202"
    tags         = ["ct", "terraform", "monitoring"]

    # Other Settings
    onboot  = true
    nesting = true
    keyctl  = false
}
module "medusa" {
    source = "../../modules/proxmox_lxc"

    enable_ssh_hardening = true
    alpine_ssh_hardening = false
    pve_connection = var.pve_connection
    ssh_public_keys = file(pathexpand("~/.ssh/vuk.lekic.pub"))
    target_node     = "homelab-vukilis"
    ostemplate      = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    start_at_boot   = true

    vmid          = 210
    root_password = var.root_password
    unprivileged  = "true"

    # Resource Allocation
    cores     = 2
    cpu_limit = 0
    cpu_units = 100
    memory    = 1024
    swap      = 0
    disk_size = "10G"
    storage   = "local-lvm"

    # Network Settings
    network_name   = "eth0"
    network_bridge = "vmbr0"
    ip_address     = "192.168.0.210/24"
    gateway        = "192.168.0.1"

    # Identity & DNS
    hostname     = "medusa"
    searchdomain = "adguard.vukilis.com"
    nameserver   = "192.168.0.202"
    tags         = ["ct", "terraform", "media"]

    # Other Settings
    onboot  = true
    nesting = true
    keyctl  = false
}
module "usememos" {
    source = "../../modules/proxmox_lxc"

    enable_ssh_hardening = true
    alpine_ssh_hardening = false
    pve_connection = var.pve_connection
    ssh_public_keys = file(pathexpand("~/.ssh/vuk.lekic.pub"))
    target_node     = "homelab-vukilis"
    ostemplate      = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    start_at_boot   = true

    vmid          = 212
    root_password = var.root_password
    unprivileged  = "true"

    # Resource Allocation
    cores     = 1
    cpu_limit = 0
    cpu_units = 100
    memory    = 512
    swap      = 0
    disk_size = "10G"
    storage   = "local-lvm"

    # Network Settings
    network_name   = "eth0"
    network_bridge = "vmbr0"
    ip_address     = "192.168.0.212/24"
    gateway        = "192.168.0.1"

    # Identity & DNS
    hostname     = "usememos"
    searchdomain = "adguard.vukilis.com"
    nameserver   = "192.168.0.202"
    tags         = ["ct", "terraform", "utilities"]

    # Other Settings
    onboot  = true
    nesting = true
    keyctl  = false
}

module "stremio" {
    source = "../../modules/proxmox_lxc"

    enable_ssh_hardening = true
    alpine_ssh_hardening = false
    pve_connection = var.pve_connection
    ssh_public_keys = file(pathexpand("~/.ssh/vuk.lekic.pub"))
    target_node     = "homelab-vukilis"
    ostemplate      = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    start_at_boot   = true

    vmid          = 229
    root_password = var.root_password
    unprivileged  = "true"

    # Resource Allocation
    cores     = 2
    cpu_limit = 0
    cpu_units = 100
    memory    = 2048
    swap      = 0
    disk_size = "10G"
    storage   = "local-lvm"

    # Network Settings
    network_name   = "eth0"
    network_bridge = "vmbr0"
    ip_address     = "192.168.0.229/24"
    gateway        = "192.168.0.1"

    # Identity & DNS
    hostname     = "stremio"
    searchdomain = "adguard.vukilis.com"
    nameserver   = "192.168.0.202"
    tags         = ["ct", "media"]

    # Other Settings
    onboot  = true
    nesting = true
    keyctl  = false
}

# Test containers for homelab-vukilis node

module "test-container-0" {
    source = "../../modules/proxmox_lxc"

    enable_ssh_hardening = true
    alpine_ssh_hardening = false
    pve_connection = var.pve_connection
    ssh_public_keys = file(pathexpand("~/.ssh/vuk.lekic.pub"))
    target_node     = "pve"
    ostemplate      = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    start_at_boot   = true

    vmid          = 301
    root_password = var.root_password
    unprivileged  = "true"

    # Resource Allocation
    cores     = 2
    cpu_limit = 0
    cpu_units = 100
    memory    = 1024
    swap      = 512
    disk_size = "10G"
    storage   = "local-lvm"

    # Network Settings
    network_name   = "eth0"
    network_bridge = "vmbr0"
    ip_address     = "192.168.0.253/24"
    gateway        = "192.168.0.1"

    # Identity & DNS
    hostname     = "test-container-0"
    searchdomain = "adguard.vukilis.com"
    nameserver   = "192.168.0.202"
    tags         = ["ct", "test"]

    # Other Settings
    onboot  = true
    nesting = true
    keyctl  = false
}
module "test-container-1" {
    source = "../../modules/proxmox_lxc"

    enable_ssh_hardening = true
    alpine_ssh_hardening = false
    pve_connection = var.pve_connection
    ssh_public_keys = file(pathexpand("~/.ssh/vuk.lekic.pub"))
    target_node     = "pve"
    ostemplate      = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    start_at_boot   = true

    vmid          = 302
    root_password = var.root_password
    unprivileged  = "true"

    # Resource Allocation
    cores     = 2
    cpu_limit = 0
    cpu_units = 100
    memory    = 1024
    swap      = 0
    disk_size = "1G"
    storage   = "local-lvm"

    # Network Settings
    network_name   = "eth0"
    network_bridge = "vmbr0"
    ip_address     = "192.168.0.252/24"
    gateway        = "192.168.0.1"

    # Identity & DNS
    hostname     = "test-container-1"
    searchdomain = "adguard.vukilis.com"
    nameserver   = "192.168.0.202"
    tags         = ["ct", "test"]

    # Other Settings
    onboot  = true
    nesting = true
    keyctl  = false
}