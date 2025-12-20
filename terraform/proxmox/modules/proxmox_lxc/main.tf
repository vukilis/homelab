terraform {
    required_providers {
            proxmox = {
            source  = "telmate/proxmox"
            version = "3.0.2-rc07"
        }
    }
}

resource "proxmox_lxc" "container" {
    ssh_public_keys = var.ssh_public_keys

    target_node  = var.target_node
    ostemplate   = var.ostemplate
    start        = var.start_at_boot

    vmid         = var.vmid
    password     = var.root_password
    unprivileged = var.unprivileged

    # Resource Allocation
    cores        = var.cores
    cpulimit     = var.cpu_limit 
    cpuunits     = var.cpu_units
    memory       = var.memory
    swap         = var.swap      

    rootfs {
        storage = var.storage
        size    = var.disk_size
    }

    # Network Settings
    network {
        name   = var.network_name
        bridge = var.network_bridge
        ip     = var.ip_address
        gw     = var.gateway
    }

    # Identity & DNS
    hostname     = var.hostname
    searchdomain = var.searchdomain
    nameserver   = var.nameserver

    # Other Settings
    onboot = var.onboot

    features {
        nesting = var.nesting
        keyctl  = var.keyctl
    }



    provisioner "local-exec" {
    command = <<EOT
        sleep $[ ( ${self.vmid} % 5 ) + 1 ]

        ssh -o StrictHostKeyChecking=no \
            -o UserKnownHostsFile=/dev/null \
            -o IdentitiesOnly=yes \
            -o ConnectTimeout=10 \
            -i "~/.ssh/vuk.lekic" root@${var.pve_connection} \
            "pct exec ${self.vmid} -- sed -i 's/^#*PermitRootLogin.*/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config && \
            pct exec ${self.vmid} -- systemctl restart ssh"
    EOT
    }
}