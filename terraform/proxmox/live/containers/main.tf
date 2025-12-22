module "test-container-0" {
    source = "../../modules/proxmox_lxc"

    ssh_public_keys = file(pathexpand("~/.ssh/vuk.lekic.pub"))
    target_node     = "pve"
    ostemplate      = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    start_at_boot   = true

    vmid          = 100
    root_password = var.root_password
    unprivileged  = "true"

    # Resource Allocation
    cores     = 2
    cpu_limit = 0
    cpu_units = 100
    memory    = 512
    swap      = 512
    disk_size = "10G"
    storage   = "local-lvm"

    # Network Settings
    network_name   = "eth0"
    network_bridge = "vmbr0"
    ip_address     = "192.168.0.229/24"
    gateway        = "192.168.0.1"

    # Identity & DNS
    hostname     = "test-container-0"
    searchdomain = "adguard.vukilis.com"
    nameserver   = "192.168.0.202"

    # Other Settings
    onboot  = true
    nesting = true
    keyctl  = false

    # Remote Exec Provisioner to enable root SSH login
    pve_connection = var.pve_connection
}
module "test-container-1" {
    source = "../../modules/proxmox_lxc"

    ssh_public_keys = file(pathexpand("~/.ssh/vuk.lekic.pub"))
    target_node     = "pve"
    ostemplate      = "local:vztmpl/debian-13-standard_13.1-2_amd64.tar.zst"
    start_at_boot   = true

    vmid          = 101
    root_password = var.root_password
    unprivileged  = "true"

    # Resource Allocation
    cores     = 4
    cpu_limit = 0
    cpu_units = 100
    memory    = 1024
    swap      = 0
    disk_size = "10G"
    storage   = "local-lvm"

    # Network Settings
    network_name   = "eth0"
    network_bridge = "vmbr0"
    ip_address     = "192.168.0.230/24"
    gateway        = "192.168.0.1"

    # Identity & DNS
    hostname     = "test-container-1"
    searchdomain = "adguard.vukilis.com"
    nameserver   = "192.168.0.202"

    # Other Settings
    onboot  = true
    nesting = true
    keyctl  = false

    # Remote Exec Provisioner to enable root SSH login
    pve_connection = var.pve_connection
}