output "gcp_worker_instance_private_ip" {
  description = "Private IP of created GCP instance."
  value       = google_compute_instance.worker[*].network_interface.0.network_ip
}