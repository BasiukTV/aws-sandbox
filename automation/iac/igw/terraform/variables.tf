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

variable "descriptor" {
  type        = string
  description = "Optional descriptor for the resource, like 'private', 'oublic', etc."
  default     = ""
}

variable "env" {
  type        = string
  description = "Optioal name of the deployment environment (like dev, test, prod, etc.)"
  default     = "test"
}

variable "region" {
  type        = string
  description = "Optional provisioned resource region."
  default     = "us-east-1"

  validation {
    condition     = var.region == null || can(regex("^[a-z]{2}-[a-z]+-[1-9]$", var.region))
    error_message = "Region must be in the format 'us-east-1', 'eu-west-1', etc."
  }
}

# Variables for Internet Gateway configuration

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to attach the Internet Gateway to."
}

variable "subnet_ids" {
  type        = map(string)
  description = "Set of subnet IDs to associate with the Internet Gateway."
}
