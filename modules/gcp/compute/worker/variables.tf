variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}
variable "gcp_region" {
  default = "us-central1"
}
variable "machine_type"{
    default = "e2-medium"
}
variable "disk_size"{
    default = 30
}
variable "vpc_name"{
    description = "vpc name"
    type = string
}
variable "subnet_name"{
    description = "description name"
    type = string
}
variable "gcp_worker_count" {
    default = 1
}

variable "gcp_worker_name" {
    description = "instance name"
    type = string
}
