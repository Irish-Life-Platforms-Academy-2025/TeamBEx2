output "public_vms" {
  description = "Public IPs"
  value = azurerm_public_ip.public_vm_pips[*].ip_address
}