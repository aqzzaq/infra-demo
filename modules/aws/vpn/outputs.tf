output "vpn_gateway_public_ips" {
  value = [
    aws_vpn_connection.ha_tunnels1.tunnel1_address,
    aws_vpn_connection.ha_tunnels1.tunnel2_address,
    aws_vpn_connection.ha_tunnels2.tunnel1_address,
    aws_vpn_connection.ha_tunnels2.tunnel2_address
  ]
}
output "aws_tunnel1_bgp_asn" {
  description = "AWS BGP ASN for Tunnel 1"
  value       = aws_vpn_connection.ha_tunnels1.tunnel1_bgp_asn
}

output "aws_tunnel2_bgp_asn" {
  description = "AWS BGP ASN for Tunnel 2"
  value       = aws_vpn_connection.ha_tunnels1.tunnel2_bgp_asn
}
output "aws_tunnel3_bgp_asn" {
  description = "AWS BGP ASN for Tunnel 1"
  value       = aws_vpn_connection.ha_tunnels2.tunnel1_bgp_asn
}

output "aws_tunnel4_bgp_asn" {
  description = "AWS BGP ASN for Tunnel 2"
  value       = aws_vpn_connection.ha_tunnels2.tunnel2_bgp_asn
}