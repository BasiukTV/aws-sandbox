output "resource_name_template" {
  description = "Template for constructing resource names. %s is the placeholder for the resource type short name."
  value       = local.resource_name_template
}

output "ec2_instance" {
  description = "Standard EC2 Instance name for the application."
  value       = format(local.resource_name_template, "ec2")
}

output "iam_policy" {
  description = "Standard IAM Policy name for the application."
  value       = format(local.resource_name_template, "iampol")
}

output "iam_user" {
  description = "Standard IAM User name for the application."
  value       = format(local.resource_name_template, "iamusr")
}

output "internet_gateway" {
  description = "Standard Internet Gateway name for the application."
  value       = format(local.resource_name_template, "igw")
}

output "nacl" {
  description = "Standard Network ACL name for the application."
  value       = format(local.resource_name_template, "nacl")
}

output "route_table" {
  description = "Standard Route Table name for the application."
  value       = format(local.resource_name_template, "rt")
}

output "subnet" {
  description = "Standard Subnet name for the application."
  value       = format(local.resource_name_template, "subnet")
}

output "vpc" {
  description = "Standard VPC name for the application."
  value       = format(local.resource_name_template, "vpc")
}
