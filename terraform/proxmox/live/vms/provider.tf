terraform {

    required_version = ">= 0.13.0"

    backend "s3" {
        bucket                      = "homelab-terraform-state"
        key                         = "proxmox/live/vms/terraform.tfstate"
        region                      = "auto"
        endpoints = {
          s3 = "https://7171193dbdb036550cb7f3cf33ef37e3.r2.cloudflarestorage.com"
        }

        skip_credentials_validation = true
        skip_region_validation      = true
        skip_requesting_account_id  = true
        skip_metadata_api_check     = true
        skip_s3_checksum            = true
    }
    required_providers {
      proxmox = {
        source  = "Telmate/proxmox"
        version = "3.0.2-rc07"
      }
    }
}

provider "proxmox" {
    pm_api_url          = var.proxmox_api_url
    pm_api_token_id     = var.proxmox_api_token_id
    pm_api_token_secret = var.proxmox_api_token_secret

    pm_tls_insecure = true
}