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

# Variables for Subnet configuration

variable "subnets_config" {
  type = map(object({
    descriptor = string
    cidr       = string
    zone       = string
  }))
  description = "List of subnets to create with their configurations."

  default = {
    "private" : {
      descriptor = "private"
      cidr       = "10.0.0.0/24"
      zone       = "us-east-1a"
    },
    "public" : {
      descriptor = "public"
      cidr       = "10.0.1.0/24"
      zone       = "us-east-1a"
    }
  }
}

# Variables for Network ACL configuration
variable "nacl_config" {
  description = "Configuration for Network ACLs. Each entry defines a NACL and its associated rules. Subnet descriptor must match a key in `subnets_config`."

  type = map(object({
    subnet_descriptor          = string
    allow_public_inbound_ssh   = bool
    allow_public_inbound_http  = bool
    allow_public_inbound_https = bool
    allow_public_inbound_ping  = bool
    allow_public_outbound      = bool
    custom_inbound_rules = map(object({
      rule_number = number
      protocol    = string
      rule_action = string
      cidr_block  = string
      from_port   = number
      to_port     = number
    }))
    custom_outbound_rules = map(object({
      rule_number = number
      protocol    = string
      rule_action = string
      cidr_block  = string
      from_port   = number
      to_port     = number
    }))
  }))

  default = {
    "public" : {
      subnet_descriptor          = "public"
      allow_public_inbound_ssh   = true
      allow_public_inbound_http  = true
      allow_public_inbound_https = true
      allow_public_inbound_ping  = true
      allow_public_outbound      = true
      custom_inbound_rules       = {}
      custom_outbound_rules      = {}
    },
    "private" : {
      subnet_descriptor          = "private"
      allow_public_inbound_ssh   = false
      allow_public_inbound_http  = false
      allow_public_inbound_https = false
      allow_public_inbound_ping  = false
      allow_public_outbound      = true
      custom_inbound_rules       = {}
      custom_outbound_rules      = {}
    }
  }
}

# Variables for Internet Gateway configuration
variable "enable_internet_gateway" {
  type        = bool
  description = "Whether to create an Internet Gateway for the VPC public subnet."
  default     = true
}
