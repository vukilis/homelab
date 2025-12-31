# Production Virtual Machines for homelab-vukilis node


# Test VM for experimenting
module "test-vm-0" {
    source          = "../../modules/proxmox_vms"

    hostname            = "test-vm-0"
    target_node         = "homelab-vukilis"
    vmid                = 351
    description         = "Test VM for experimentation"              
    vm_state            = "started"
    boot                = "order=scsi0;net0"
    start_at_node_boot  = true
    source_template     = "debian-13-template-vm"
    sockets             = 1
    cores               = 2
    type                = "x86-64-v2-AES"
    numa                = false
    cpu_units           = 100
    cpu_limit           = 0
    memory              = 2048
    scsihw              = "virtio-scsi-single"
    disk_size           = "20G"
    storage             = "local-lvm"
    model_type          = "virtio"
    network_bridge      = "vmbr0"
    ip_address          = "192.168.0.252/24"
    gateway             = "192.168.0.1"
    nameserver          = "192.168.0.202"
    searchdomain        = "adguard.vukilis.com"
    ssh_public_keys     = file(pathexpand("~/.ssh/vuk.lekic.pub"))
    ci_user             = "homelab"
    root_password       = var.root_password
    tags                = ["terraform", "vm", "test"]
}