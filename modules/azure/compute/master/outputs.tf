output "azure_control_plane_instance_private_ip" {
  description = "Private IP of created GCP instance."
  value       = azurerm_linux_virtual_machine.control_plane[*].private_ip_address
}