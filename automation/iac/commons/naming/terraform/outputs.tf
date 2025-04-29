output "resource_name_template" {
  description = "Template for constructing resource names. %s is the placeholder for the resource type short name."
  value       = local.resource_name_template
}

output "vpc" {
  description = "Standard VPC name for the application."
  value       = format(local.resource_name_template, "vpc")
}
