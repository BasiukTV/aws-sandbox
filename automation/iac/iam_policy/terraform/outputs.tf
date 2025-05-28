# This file defines the outputs for the Internet Gateway Terraform module.

output "iam_policy_arn" {
  description = "ARN of the created IAM policy."
  value       = aws_iam_policy.aimpol.arn
}

output "iam_policy_id" {
  description = "ID of the created IAM policy."
  value       = aws_iam_policy.aimpol.id
}

output "iam_policy_name" {
  description = "Name of the created IAM policy."
  value       = aws_iam_policy.aimpol.name
}

output "iam_policy_description" {
  description = "Description of the created IAM policy."
  value       = aws_iam_policy.aimpol.description
}

output "iam_policy_path" {
  description = "Path of the created IAM policy."
  value       = aws_iam_policy.aimpol.path
}

output "iam_policy_document" {
  description = "JSON document of the created IAM policy."
  value       = data.aws_iam_policy_document.aimpol_doc.json
}
