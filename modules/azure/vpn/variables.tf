variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "gateway_subnet_id" {
  description = "ID of GatewaySubnet"
  type        = string
}

variable "azure_spoke_bgp_asn" {
  description = "Spoke BGP ASN"
  type        = number
  default     = 65003
}

variable "gcp_bgp_asn" {
  type = number
}

variable "shared_secret" {
  description = "VPN shared secret"
  type        = string
  sensitive   = true
}


variable "gcp_vpn_gateway_ips" {
  description = "List of GCP HA VPN Gateway public IPs"
  type        = list(string)
}