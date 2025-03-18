output "tunnel1_name" {
  description = "Name of VPN Tunnel 1"
  value       = google_compute_vpn_tunnel.tunnel1[*].name
}

output "tunnel2_name" {
  description = "Name of VPN Tunnel 2"
  value       = google_compute_vpn_tunnel.tunnel2[*].name
}