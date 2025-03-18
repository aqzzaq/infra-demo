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