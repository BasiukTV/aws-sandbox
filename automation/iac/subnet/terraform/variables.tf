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
  default     = "private"
}

variable "env" {
  type        = string
  description = "Optioal name of the deployment environment (like dev, test, prod, etc.)"
  default     = "test"
}

variable "zone" {
  type        = string
  description = "Provisioned resource zone."
  default = "us-east-1a"

  validation {
    condition     = var.zone == null || can(regex("^[a-z]{2}-[a-z]+-[1-9][a-z]$", var.zone))
    error_message = "Zone must be in the format 'us-east-1a', 'eu-west-1a', etc."
  }
}

# Variables for Subnet configuration

variable "subnet_name_override" {
  type        = string
  description = "(Optional) Subnet name override. If not provided, the name will be generated based on naming variables values."
  default     = null
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC where the subnet will be created."

  validation {
    condition     = can(regex("^vpc-[0-9a-f]{8,17}$", var.vpc_id))
    error_message = "VPC ID must be in the format 'vpc-xxxxxxxx' where x is a hexadecimal character."
  }
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR block for the subnet."
  default     = "10.0.0.0/24"

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.subnet_cidr))
    error_message = "Subnet CIDR must be in the format 'x.x.x.x/x' where x is a number between 0 and 255."
  }
}
