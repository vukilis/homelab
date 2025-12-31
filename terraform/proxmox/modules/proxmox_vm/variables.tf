# --- Access ---
variable "ssh_public_keys" {
    type        = string
    description = "Public SSH keys to inject into the cloud-init user."
}

variable "ci_user" {
    type        = string
    description = "The username for the cloud-init user."
    default     = "homelab"
}

variable "root_password" {
    type        = string
    description = "The root password for the virtual machine."
}

variable "target_node" {
    type        = string
    description = "The name of the Proxmox node where the VM will be created."
}

# --- Instance Configuration ---
variable "hostname" {
    type        = string
    description = "The hostname for the virtual machine."
}

variable "vmid" {
    type        = number
    description = "The unique VM ID for the virtual machine."
}

variable "description" {
    type        = string
    description = "A description for the virtual machine."
    default     = ""
}

variable "vm_state" {
    type        = string
    description = "Initial state of the virtual machine (started or stopped)."
    default     = "started"
}

variable "boot" {
    type        = string
    description = "Boot order for the virtual machine."
    default     = "order=scsi0;net0"
}

variable "start_at_node_boot" {
    type        = bool
    description = "Whether to start the VM automatically when the Proxmox node boots."
    default     = true
}

variable "source_template" {
    type        = string
    description = "The name of the VM template to clone."
}

# --- Resources ---
variable "sockets" {
    type        = number
    description = "Number of CPU sockets to allocate."
    default     = 1
}

variable "cores" {
    type        = number
    description = "Number of CPU cores to allocate."
    default     = 1
}

variable "type" {
    type        = string
    description = "CPU type."
    default     = "host"
}

variable "numa" {
    type        = bool
    description = "Enable NUMA for the VM."
    default     = false
}

variable "cpu_limit" {
    type        = number
    description = "CPU limit in MHz (0 for no limit)."
    default     = 0
}

variable "cpu_units" {
    type        = number
    description = "CPU weight units (relative priority)."
    default     = 100
}

variable "memory" {
    type        = number
    description = "Amount of RAM in MB."
    default     = 512
}

variable "scsihw" {
    type        = string
    description = "SCSI controller type."
    default     = "virtio-scsi-single"
}

variable "disk_size" {
    type        = string
    description = "Size of the root disk (e.g., 20G)."
    default     = "20G"
}

variable "storage" {
    type        = string
    description = "The storage pool where the disk will be created."
    default     = "local-lvm"
}

# --- Networking ---

variable "model_type" {
    type        = string
    description = "The model type for the network interface."
    default     = "virtio"
}

variable "network_bridge" {
    type        = string
    description = "The network bridge to attach the VM's network interface to."
    default     = "vmbr0"
}

variable "ip_address" {
    type        = string
    description = "The IP address in CIDR format (e.g., 192.168.0.201/24) or 'dhcp'."
    default     = "dhcp"
}

variable "gateway" {
    type        = string
    description = "The default gateway (only needed if using a static IP)."
    default     = null
}

variable "searchdomain" {
    type        = string
    description = "The DNS search domain (e.g., home.arpa or local)."
    default     = null
}

variable "nameserver" {
    type        = string
    description = "The DNS server IP address (e.g., 1.1.1.1 or 8.8.8.8)."
    default     = null
}

# --- Additional Settings ---

variable "tags" {
    type        = list(string)
    description = "A list of tags to apply to the virtual machine."
    default     = []
}