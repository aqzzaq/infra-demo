output "ha_vpn_gateway_ips" {
  value = [
    google_compute_ha_vpn_gateway.ha_vpn_gw.vpn_interfaces[0].ip_address,
    google_compute_ha_vpn_gateway.ha_vpn_gw.vpn_interfaces[1].ip_address
  ]
}
output "ha_vpn_gateway_id" {
  value = google_compute_ha_vpn_gateway.ha_vpn_gw.id
}