variable "aws_region" {
  description = "AWS region (e.g., us-east-1)"
  type        = string
  default     = "us-east-1"
}

variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
  default     = "gcp-project-id"
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
variable "azure_spoke_bgp_asn"{
  description = "Azure BGP ASN"
  type        = number
  default     = 65003 
}

variable "aws_availability_zone" {
  default = "us-east-1a"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "dev-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}

variable "vnet_cidr" {
  description = "Virtual Network CIDR block"
  type        = string
  default     = "10.1.0.0/16"
}

variable "subnets" {
  description = "Subnet configuration"
  type = map(object({
    address_prefixes = list(string)
  }))
  default = {
    public = {
      address_prefixes = ["10.1.1.0/24"]
    }
    private = {
      address_prefixes = ["10.1.2.0/24"]
    }
  }
}

variable "nsg_rules" {
  description = "Network Security Group rules"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "allow-all-inbound"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-all-outbound"
      priority                   = 101
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}

variable "aws_master_count" {
    default = 1
}
variable "aws_instance_type" {
    default = "t3.medium" 
}
variable "aws_worker_count" {
    default = 1
}
variable "azure_worker_count" {
    default = 1
}
variable "azure_master_count" {
    default = 1
}
variable "azure_vm_size" {
    default = "Standard_B2s" 
}
variable "gcp_worker_count" {
    default = 1
}
variable "gcp_master_count" {
    default = 1
}
variable "gcp_machine_type" {
    default = "e2-medium"
}

variable "aws_private_subnet_id" {
    default = "xxx"
}
variable "aws_security_group_id" {
    default = "xxx"
}
variable "azure_subnet_id" {
    default = "xxx"
}
variable "gcp_vpc_name" {
  default = "gcp-vpc"
}
variable "gcp_subnet_name" {
    default = "private-subneta"
}
variable "gcp_compute_instance_master_name" {
    default = "gcp-k8s-control-plane"
}
variable "gcp_compute_instance_worker_name" {
    default = "gcp-k8s-worker"
}
variable "azure_vm_master_name" {
    default = "azure-k8s-control-plane"
}
variable "azure_vm_worker_name" {
    default = "azure-k8s-worker"
}
variable "aws_ec2_master_name" {
    default = "aws-k8s-control-plane"
}
variable "aws_ec2_worker_name" {
    default = "aws-k8s-worker"
}
variable "scale_operation" {
    default = "false"
}