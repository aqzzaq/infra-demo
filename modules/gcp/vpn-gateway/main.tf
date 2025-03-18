resource "google_compute_ha_vpn_gateway" "ha_vpn_gw" {
  name    = "ha-vpn-gateway"
  network = var.vpc_id
  region  = var.region
}