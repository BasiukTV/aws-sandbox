output "nacl_id" {
  description = "The ID of the provisioned Network ACL."
  value       = aws_network_acl.nacl.id
}

output "nacl_name" {
  description = "The name of the provisioned Network ACL."
  value       = aws_network_acl.nacl.tags["Name"]
}
