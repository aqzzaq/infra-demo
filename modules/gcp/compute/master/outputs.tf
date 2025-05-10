output "gcp_control_plane_instance_private_ip" {
  description = "Private IP of created GCP instance."
  value       = google_compute_instance.control_plane[*].network_interface.0.network_ip
}