output "aws_control_plane_instance_private_ip" {
  description = "Private IP of created GCP instance."
  value       = aws_instance.control_plane[*].private_ip
}