output "azure_worker_instance_private_ip" {
  description = "Private IP of created GCP instance."
  value       = azurerm_linux_virtual_machine.worker[*].private_ip_address
}