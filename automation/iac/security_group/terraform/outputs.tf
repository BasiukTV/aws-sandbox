# Outputs for the security group module
output "security_group_name" {
  description = "Name of the created security group."
  value       = aws_security_group.sg.name
}

output "security_group_id" {
  description = "ID of the created security group."
  value       = aws_security_group.sg.id
}