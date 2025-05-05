output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = aws_vpc.vpc.tags["Name"]
}

output "subnet_ids" {
  description = "A map of subnet IDs keyed by subnet name"
  value       = { for k, v in module.subnets : k => v.subnet_id }
}

output "subnet_names" {
  description = "A map of subnet names keyed by subnet ID"
  value       = { for k, v in module.subnets : k => v.subnet_name }
}

output "nacl_ids" {
  description = "A map of Network ACL IDs keyed by descriptor"
  value       = { for k, v in module.nacl : k => v.nacl_id }
}

output "nacl_names" {
  description = "A map of Network ACL names keyed by descriptor"
  value       = { for k, v in module.nacl : k => v.nacl_name }
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = var.enable_internet_gateway ? module.igw[0].igw_id : null
}

output "igw_name" {
  description = "The name of the Internet Gateway"
  value       = var.enable_internet_gateway ? module.igw[0].igw_name : null
}

output "public_subnet_route_table_id" {
  description = "The ID of the Route Table"
  value       = var.enable_internet_gateway ? module.igw[0].route_table_id : null
}

output "public_subnet_route_table_name" {
  description = "The name of the Route Table"
  value       = var.enable_internet_gateway ? module.igw[0].route_table_name : null
}
