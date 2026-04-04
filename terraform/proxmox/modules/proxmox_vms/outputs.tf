output "test-vm-0" {
    description = try("The IPv4 address of the VM", "Description not found")
    value       = proxmox_vm_qemu.virtual_machine.default_ipv4_address
}