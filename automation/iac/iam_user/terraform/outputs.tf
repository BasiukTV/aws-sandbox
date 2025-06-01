# This file defines the outputs for the IAM User Terraform module.

output "iam_user_arn" {
  description = "ARN of the created IAM user."
  value       = aws_iam_user.user.arn
}

output "iam_user_id" {
  description = "ID of the created IAM user."
  value       = aws_iam_user.user.id
}

output "iam_user_name" {
  description = "Name of the created IAM user."
  value       = aws_iam_user.user.name
}

output "iam_access_key_id" {
  description = "ID of the created IAM access key."
  value       = var.make_access_key ? aws_iam_access_key.access_key[0].id : null
}

output "iam_access_key_secret" {
  description = "Secret of the created IAM access key."
  sensitive   = true
  value       = var.make_access_key ? aws_iam_access_key.access_key[0].secret : null
}
