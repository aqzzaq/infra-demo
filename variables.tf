variable "aws_region" {
  description = "AWS region (e.g., us-east-1)"
  type        = string
  default     = "us-east-1"
}

variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
  default     = "neat-dynamo-453408-h5"
}

variable "gcp_region" {
  description = "GCP region (e.g., us-central1)"
  type        = string
  default     = "us-central1"
}

variable "aws_vpc_cidr" {
  description = "AWS VPC CIDR (e.g., 10.0.0.0/16)"
  type        = string
  default     = "10.0.0.0/16"
}

variable "gcp_vpc_cidr" {
  description = "GCP VPC CIDR (e.g., 192.168.0.0/16)"
  type        = string
  default     = "192.168.0.0/16"
}

variable "aws_public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "aws_private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "gcp_public_subnet_cidr" {
  default = "192.168.1.0/24"
}

variable "gcp_private_subnet_cidr" {
  default = "192.168.2.0/24"
}

variable "shared_secret" {
  description = "VPN pre-shared key"
  type        = string
  sensitive   = true
}

variable "aws_bgp_asn" {
  description = "AWS BGP ASN"
  type        = number
  default     = 65001
}

variable "gcp_bgp_asn" {
  description = "GCP BGP ASN"
  type        = number
  default     = 65000
}

variable "aws_availability_zone" {
  default = "us-east-1a"
}

variable "gcp_vpc_name" {
  default = "gcp-vpc"
}