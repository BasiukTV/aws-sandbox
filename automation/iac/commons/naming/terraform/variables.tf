# Variables for naming resources in Terraform

variable "separator" {
  type        = string
  description = "Separator used in the resource name. Default is '-'."
  default     = "-"
}

variable "org" {
  type        = string
  description = "The optional name of the organization owning the resource."
  default     = null

  validation {
    condition     = var.org == null || can(regex("^[a-z0-9-]+$", var.org))
    error_message = "Organization name must be lowercase alphanumeric with dashes."
  }
}

variable "app" {
  type        = string
  description = "The name of the app owning the resource."
  default     = "awssbx"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.app))
    error_message = "App name must be lowercase alphanumeric with dashes."
  }
}

variable "descriptor" {
  type        = string
  description = "Additional optional app descriptor (like db, api, web, etc.)"
  default     = null

  validation {
    condition     = var.descriptor == null || can(regex("^[a-z0-9-]+$", var.descriptor))
    error_message = "Descriptor must be lowercase alphanumeric with dashes."
  }
}

variable "index" {
  type        = string
  description = "Optional resource index for multiple resources of the same type. Multiple indexes need multiplese instances of the module."
  default     = null

  validation {
    condition     = var.index == null || can(regex("^[0-9]+$", var.index)) || var.index == null
    error_message = "Index must be a number or null."
  }
}

variable "env" {
  type        = string
  description = "Optioal name of the deployment environment (like dev, test, prod, etc.)"
  default     = "test"

  validation {
    condition     = var.env == null || can(regex("^[a-z0-9-]+$", var.env))
    error_message = "Environment name must be lowercase alphanumeric with dashes."
  }
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

variable "zone" {
  type        = string
  description = "Optional provisioned resource zone. If provided, this will override the region."
  default     = null
  validation {
    condition     = var.zone == null || can(regex("^[a-z]{2}-[a-z]+-[1-9][a-z]$", var.zone))
    error_message = "Zone must be in the format 'us-east-1a', 'eu-west-1b', etc."
  }
}
