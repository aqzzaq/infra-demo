resource "aws_instance" "control_plane" {
  count         = var.aws_master_count
  ami           = var.ami # Ubuntu 22.04 LTS (us-east-1)
  instance_type = var.instance_type           # 2 vCPU, 4 GB RAM
  key_name      = aws_key_pair.k8s.key_name
  subnet_id     = var.aws_subnet_id
  vpc_security_group_ids = var.aws_security_groups

  tags = {
    Name = "${var.aws_master_name}-${count.index}"
  }

  root_block_device {
    volume_size = 20
  }
}

# SSH Key Pair
resource "aws_key_pair" "k8s" {
  key_name   = "k8s-key"
  public_key = file(var.ssh_public_key)
}