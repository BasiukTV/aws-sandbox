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
