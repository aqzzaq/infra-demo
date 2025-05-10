resource "aws_instance" "worker" {
  count         = var.aws_worker_count
  ami           = var.ami 
  instance_type = var.instance_type             
  key_name      = "k8s-key"
  subnet_id     = var.aws_subnet_id
  vpc_security_group_ids = var.aws_security_groups

  tags = {
    Name = "${var.aws_worker_name}-${count.index}"
  }

  root_block_device {
    volume_size = 30 # 30 GB disk
  }
}
