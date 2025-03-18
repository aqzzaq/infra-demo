resource "aws_vpn_gateway" "vgw" {
  vpc_id          = var.vpc_id
  amazon_side_asn = var.aws_bgp_asn
}

resource "aws_vpn_gateway_route_propagation" "vpn_route_private" {
  vpn_gateway_id = aws_vpn_gateway.vgw.id
  route_table_id = var.private_route_table_id
}

resource "aws_vpn_gateway_route_propagation" "vpn_route_public" {
  vpn_gateway_id = aws_vpn_gateway.vgw.id
  route_table_id = var.public_route_table_id
}

resource "aws_customer_gateway" "gcp_cgw" {
  count = length(var.gcp_vpn_gateway_ips)

  bgp_asn    = var.gcp_bgp_asn
  ip_address = var.gcp_vpn_gateway_ips[count.index]
  type       = "ipsec.1"
}

resource "aws_vpn_connection" "ha_tunnels1" {
  vpn_gateway_id      = aws_vpn_gateway.vgw.id
  customer_gateway_id = aws_customer_gateway.gcp_cgw[0].id
  type                = "ipsec.1"
  static_routes_only  = false

  tunnel1_inside_cidr   = "169.254.10.0/30"
  tunnel1_preshared_key = var.shared_secret

  tunnel2_inside_cidr   = "169.254.20.0/30"
  tunnel2_preshared_key = var.shared_secret
}

resource "aws_vpn_connection" "ha_tunnels2" {
  vpn_gateway_id      = aws_vpn_gateway.vgw.id
  customer_gateway_id = aws_customer_gateway.gcp_cgw[1].id
  type                = "ipsec.1"
  static_routes_only  = false

  tunnel1_inside_cidr   = "169.254.30.0/30"
  tunnel1_preshared_key = var.shared_secret

  tunnel2_inside_cidr   = "169.254.40.0/30"
  tunnel2_preshared_key = var.shared_secret
}