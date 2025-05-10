output "aws_worker_instance_private_ip" {
  description = "Private IP of created GCP instance."
  value       = aws_instance.worker[*].private_ip
}