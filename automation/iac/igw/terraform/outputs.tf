# This file defines the outputs for the Internet Gateway Terraform module.

output "igw_id" {
  description = "The ID of the provisioned Internet Gateway."
  value       = aws_internet_gateway.igw.id
}

output "igw_name" {
  description = "The name of the provisioned Internet Gateway."
  value       = aws_internet_gateway.igw.tags["Name"]
}

output "route_table_id" {
  description = "The ID of the route table associated with the Internet Gateway."
  value       = aws_route_table.rt.id
}

output "route_table_name" {
  description = "The name of the route table associated with the Internet Gateway."
  value       = aws_route_table.rt.tags["Name"]
}
