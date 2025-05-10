output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private.id
}

output "public_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.public.id
}

output "private_subnet_id" {
  description = "ID of the private route table"
  value       = aws_subnet.private.id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.instance_sg.id
}