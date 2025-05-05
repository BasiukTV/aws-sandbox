output "resource_name_template" {
  description = "Template for constructing resource names. %s is the placeholder for the resource type short name."
  value       = local.resource_name_template
}

output "vpc" {
  description = "Standard VPC name for the application."
  value       = format(local.resource_name_template, "vpc")
}

output "subnet" {
  description = "Standard Subnet name for the application."
  value       = format(local.resource_name_template, "subnet")
}

output "nacl" {
  description = "Standard Network ACL name for the application."
  value       = format(local.resource_name_template, "nacl")
}

output "internet_gateway" {
  description = "Standard Internet Gateway name for the application."
  value       = format(local.resource_name_template, "igw")
}

output "route_table" {
  description = "Standard Route Table name for the application."
  value       = format(local.resource_name_template, "rt")
}
