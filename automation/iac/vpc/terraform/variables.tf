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
  description = "Optional provisioned resource region. If zone is provided, this will be ignored."
  validation {
    condition     = var.region == null || can(regex("^[a-z]{2}-[a-z]+-[1-9]$", var.region))
    error_message = "Region must be in the format 'us-east-1', 'eu-west-1', etc."
  }
  default = "us-east-1"
}

# Variables for VPC configuration

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS support in the VPC."
  default     = true
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in the VPC."
  default     = true
}

