variable "vpc_id" {
  type = string
}

variable "gcp_vpn_gateway_ips" {
  description = "List of GCP HA VPN Gateway public IPs"
  type        = list(string)
}

variable "shared_secret" {
  type        = string
  sensitive   = true
}

variable "aws_bgp_asn" {
  type = number
}

variable "gcp_bgp_asn" {
  type = number
}

variable "private_route_table_id" {
  type = string
}
variable "public_route_table_id" {
  type = string
}