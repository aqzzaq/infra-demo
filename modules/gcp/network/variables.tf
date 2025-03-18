variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "gcp-vpc"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "192.168.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "192.168.2.0/24"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}
