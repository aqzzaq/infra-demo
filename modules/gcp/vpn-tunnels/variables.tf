variable "vpc_id" {
  description = "ID of the GCP VPC"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "gcp_bgp_asn" {
  description = "GCP BGP ASN"
  type        = number
}

variable "shared_secret" {
  description = "Pre-shared key for the VPN tunnels"
  type        = string
  sensitive   = true
}

variable "aws_vpn_gateway_ips" {
  description = "Public IPs of the AWS VPN Gateway (Tunnel 1 and 2)"
  type        = list(string)
}

variable "azure_vpn_gateway_ips" {
  description = "Public IPs of the AWS VPN Gateway (Tunnel 1 and 2)"
  type        = list(string)
}

variable "aws_tunnel1_bgp_asn" {
  description = "AWS BGP ASN for Tunnel 1"
  type        = number
}

variable "aws_tunnel2_bgp_asn" {
  description = "AWS BGP ASN for Tunnel 2"
  type        = number
}

variable "aws_tunnel3_bgp_asn" {
  description = "AWS BGP ASN for Tunnel 1"
  type        = number
}

variable "aws_tunnel4_bgp_asn" {
  description = "AWS BGP ASN for Tunnel 2"
  type        = number
}

variable "azure_bgp_asn" {
  description = "Azure BGP ASN"
  type        = number
}

variable "ha_vpn_gateway_id" {
  description = "ID of the GCP HA VPN Gateway"
  type        = string
}