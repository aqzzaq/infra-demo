output "vpn_gateway_public_ips" {
  value = [
    azurerm_public_ip.azure_vpn_ip1.ip_address,
    azurerm_public_ip.azure_vpn_ip2.ip_address,
  ]
}