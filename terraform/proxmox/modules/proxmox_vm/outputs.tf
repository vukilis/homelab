output "test-vm-0" {
    description = "The IPv4 address of the VM"
    value       = proxmox_vm_qemu.virtual_machine.default_ipv4_address
}