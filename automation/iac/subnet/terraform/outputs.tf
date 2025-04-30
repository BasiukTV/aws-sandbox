output "subnet_name" {
    description = "The name of the provisioned subnet."
    value       = aws_subnet.subnet.tags["Name"]
}

output "subnet_id" {
    description = "The ID of the provisioned subnet."
    value       = aws_subnet.subnet.id
}