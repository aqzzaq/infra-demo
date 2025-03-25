variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region (e.g., East US)"
  type        = string
}

variable "environment" {
  description = "Environment tag (e.g., prod, dev)"
  type        = string
}

variable "vnet_cidr" {
  description = "VNet address space"
  type        = string
}

variable "subnets" {
  description = "Subnet configuration"
  type = map(object({
    address_prefixes = list(string)
  }))
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
  default = []
}