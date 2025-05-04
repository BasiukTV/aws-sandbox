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
  validation {
    condition     = var.region == null || can(regex("^[a-z]{2}-[a-z]+-[1-9]$", var.region))
    error_message = "Region must be in the format 'us-east-1', 'eu-west-1', etc."
  }
  default = "us-east-1"
}

variable "descriptor" {
  type        = string
  description = "Optional descriptor for the resource, like 'private', 'oublic', etc."
  default     = "private"
}

# Variables for NACL association with VPC and subnets

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to associate the NACL with."
}

variable "subnet_ids" {
  type        = map(string)
  description = "Map of subnet IDs to associate with the NACL."
  default     = {}
}

# Varibles for NACL rules

variable "allow_public_inbound_ssh" {
  type        = bool
  description = "Whether to allow public inbound SSH traffic (port 22)."
  default     = false
}

variable "allow_public_inbound_http" {
  type        = bool
  description = "Whether to allow public inbound HTTP traffic (port 80)."
  default     = false
}

variable "allow_public_inbound_https" {
  type        = bool
  description = "Whether to allow public inbound HTTPS traffic (port 443)."
  default     = false
}

variable "allow_public_inbound_ping" {
  type        = bool
  description = "Whether to allow public inbound ICMP traffic (ping)."
  default     = false
}

variable "allow_public_outbound" {
  type        = bool
  description = "Whether to allow public outbound traffic."
  default     = false
}

variable "custom_inbound_rules" {
  type = map(object({
    rule_number = number
    protocol    = string
    rule_action = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
  description = "Custom inbound rules for the NACL."
  default     = {}
}

variable "custom_outbound_rules" {
  type = map(object({
    rule_number = number
    protocol    = string
    rule_action = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
  description = "Custom outbound rules for the NACL."
  default     = {}
}
