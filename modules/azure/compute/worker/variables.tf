variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}
variable "location" {
  description = "Azure region (e.g., East US)"
  type        = string
}

variable "vm_size" {
    default = "Standard_B2s"
}
variable "disk_size" {
    default = 20 
}

variable "subnet_id" {
  description = "Private subnet id"
  type        = string
}

variable "azure_worker_count" {
    default = 1
}
variable "azure_worker_name" {
    description = "instance name"
    type = string
}