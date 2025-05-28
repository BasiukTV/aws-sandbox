# Variables for naming resources in Terraform

variable "org" {
  type        = string
  description = "The optional name of the organization owning the resource."
  default     = "taras"
}

variable "app" {
  type        = string
  description = "The name of the app owning the resource."
  default     = "awssbx"
}

variable "env" {
  type        = string
  description = "Optioal name of the deployment environment (like dev, test, prod, etc.)"
  default     = "test"
}

variable "region" {
  type        = string
  description = "Optional provisioned resource region."
  default     = "us-east-2"

  validation {
    condition     = var.region == null || can(regex("^[a-z]{2}-[a-z]+-[1-9]$", var.region))
    error_message = "Region must be in the format 'us-east-1', 'eu-west-1', etc."
  }
}

# Variables for the IAM Policy

variable "policy_description" {
  type        = string
  description = "Description of the IAM policy."
  default     = "IAM policy for S3 bucket read access."
}

variable "policy_statement" {
  type = object({
    actions   = list(string)
    resources = list(string)
  })
  description = "IAM policy statement to be applied."

  # Default policy statement that allows listing and getting objects from S3 buckets.
  default = {
    actions   = ["s3:ListBucket", "s3:GetObject"]
    resources = ["arn:aws:s3:::", "arn:aws:s3:::/*"]
  }
}
