# --- Connection & Location ---
variable "proxmox_api_url" {
    description = "The Proxmox VE API URL"
    type        = string
}

variable "proxmox_api_token_id" {
    description = "The Proxmox VE API Token ID"
    type        = string
    sensitive   = true
}

variable "proxmox_api_token_secret" {
    description = "The Proxmox VE API Token Secret"
    type        = string
    sensitive   = true
}

variable "root_password" {
    description = "Root password for the virtual machines"
    type        = string
    sensitive   = true
}