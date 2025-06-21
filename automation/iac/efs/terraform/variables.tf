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
  description = "Optional descriptor for the resource, like 'private', 'public', etc."
  default     = null
}

variable "env" {
  type        = string
  description = "Optioal name of the deployment environment (like dev, test, prod, etc.)"
  default     = "test"
}

variable "region" {
  type        = string
  description = "Optional provisioned resource region."
  validation {
    condition     = var.region == null || can(regex("^[a-z]{2}-[a-z]+-[1-9]$", var.region))
    error_message = "Region must be in the format 'us-east-1', 'eu-west-1', etc."
  }
  default = "us-east-1"
}

# Variables for Elastic File System (EFS)

variable "mount_subnets" {
  description = "Subnets where the EFS mount targets will be created. Can be a list of existing subnet IDs or a boolean to create new basic VPC subnets."
  type = object({
    existing_subnet_ids = optional(map(object({
      vpc_id    = string
      subnet_id = string
    })), null)

    new_basic_vpc = optional(bool, false)
  })

  default = {
    existing_subnet_ids = null
    new_basic_vpc       = true
  }
}
