# --- Access ---
variable "ssh_public_keys" {
    type        = string
    description = "Public SSH keys to inject into the container."
}

variable "root_password" {
    type        = string
    description = "The root password for the container."
    sensitive   = true
}

variable "target_node" {
    type        = string
    description = "The name of the Proxmox node where the container will be created (e.g., pve)."
}

# --- Instance Configuration ---
variable "hostname" {
    type        = string
    description = "The hostname for the container."
}

variable "vmid" {
    type        = number
    description = "The unique VM ID for the container."
}

variable "ostemplate" {
    type        = string
    description = "The identifier for the OS template (e.g., local:vztmpl/ubuntu-22.04-standard...)."
}

variable "unprivileged" {
    type        = bool
    description = "Whether the container is unprivileged (recommended for security)."
    default     = true
}

# --- Resources ---
variable "cores" {
    type        = number
    description = "Number of CPU cores to allocate."
    default     = 1
}

variable "cpu_limit" {
    type        = number
    description = "CPU limit. 0 means unlimited."
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

variable "swap" {
    type        = number
    description = "Amount of SWAP in MB."
    default     = 512
}

variable "disk_size" {
    type        = string
    description = "Size of the root disk (e.g., 8G)."
    default     = "8G"
}

variable "storage" {
    type        = string
    description = "The storage pool where the disk will be created."
    default     = "local-lvm"
}

# --- Networking ---
variable "network_name" {
    type        = string
    description = "The name of the network interface."
    default     = "eth0"
}

variable "network_bridge" {
    type        = string
    description = "The network bridge to attach the container to."
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

variable "onboot" {
    type        = bool
    description = "Whether the container should start when the Proxmox host boots."
    default     = true
}

variable "nesting" {
    type        = bool
    description = "Enable nested virtualization (required for Docker inside LXC)."
    default     = true
}

variable "keyctl" {
    type        = bool
    description = "Enable keyctl() system call."
    default     = true
}

variable "start_at_boot" {
    type        = bool
    description = "Whether the container should start at boot."
    default     = false
}

variable "pve_connection" {
    type        = string
    description = "Connection details for remote-exec provisioner."
    default     = null
}
