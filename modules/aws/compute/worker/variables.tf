variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub" # Path to your SSH public key
}
variable "instance_type" {
    default = "t3.medium" 
}
variable "volume_size" {
    default = 30
}
variable "ami" {
    default = "ami-0f9de6e2d2f067fca"
}
variable "aws_worker_count" {
    default = 0
}
variable "aws_subnet_id" {
    description = "AWS subnet ID"
    type        = string
}
variable "aws_security_groups" {
    description = "AWS EC2 SG"
    type        = list(string)
}
variable "aws_worker_name" {
    description = "instance name"
    type = string
}