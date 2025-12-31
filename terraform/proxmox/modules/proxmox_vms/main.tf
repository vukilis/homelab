terraform {
    required_providers {
            proxmox = {
            source  = "telmate/proxmox"
            version = "3.0.2-rc07"
        }
    }
}

resource "proxmox_vm_qemu" "virtual_machine" {
    name        = var.hostname
    target_node = var.target_node
    vmid        = var.vmid
    description = var.description              
    vm_state    = var.vm_state
    boot        = var.boot

    # OS Settings
    clone      = var.source_template
    full_clone = true

    # Resource Allocation
    cpu {
        sockets = var.sockets
        cores   = var.cores
        type    = var.type     
        numa    = var.numa  
        units   = var.cpu_units
        limit   = var.cpu_limit
    }
    memory  = var.memory
    scsihw  = var.scsihw

    # Disk Settings
    disks {
        scsi {
            scsi0 { 
                disk {
                    size     = var.disk_size
                    storage  = var.storage
                    discard  = true
                    iothread = true 
                }
            }
        }

        ide {
            ide2 {
                cloudinit {
                        storage = var.storage
                    }
                }
            }
    }

    # Network Settings
    network {
        id = 0
        model  = var.model_type
        bridge = var.network_bridge
    }

    # Cloud-Init & Identity
    os_type                 = "cloud-init"
    ipconfig0               = "ip=${var.ip_address},gw=${var.gateway}"
    nameserver              = var.nameserver
    searchdomain            = var.searchdomain
    sshkeys                 = var.ssh_public_keys
    ciuser                  = var.ci_user
    cipassword              = var.root_password

    # Additional Settings
    hotplug                 = "disk,network,usb"
    start_at_node_boot      = var.start_at_node_boot
    agent                   = 1

    tags = join(";", var.tags)
}