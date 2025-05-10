output "gcp_instance_worker_private_ip" {
  description = "Private IP of created GCP worker instance."
  value       = module.gcp_worker_node.gcp_worker_instance_private_ip
}
output "gcp_instance_control_plane_private_ip" {
  description = "Private IP of created GCP control plane instance."
  value       = module.gcp_master_node.gcp_control_plane_instance_private_ip
}
output "azure_vm_worker_private_ip" {
  description = "Private IP of created Azure worker instance."
  value       = module.azure_worker_node.azure_worker_instance_private_ip
}
output "azure_vm_control_plane_private_ip" {
  description = "Private IP of created Azure control plane instance."
  value       = module.azure_master_node.azure_control_plane_instance_private_ip
}
output "aws_instance_worker_private_ip" {
  description = "Private IP of created AWS worker instance."
  value       = module.aws_worker_node.aws_worker_instance_private_ip
}
output "aws_instance_control_plane_private_ip" {
  description = "Private IP of created AWS control plane instance."
  value       = module.aws_master_node.aws_control_plane_instance_private_ip
}