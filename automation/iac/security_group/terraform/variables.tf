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
  description = "Optional descriptor for the resource, like 'ec2', 'efs', etc."
  default     = "ec2"
}

variable "env" {
  type        = string
  description = "Optional name of the deployment environment (like dev, test, prod, etc.)"
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

# Variables for Security Group (and rules)

variable "security_group_description" {
  type        = string
  description = "Description of the security group."
  default     = null
}

variable "security_group_vpc_id" {
  type        = string
  description = "VPC ID to associate the security group with."
  default     = null
}

variable "ingress_rules" {
  type = map(object({
    description      = optional(string)
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string))
    security_groups  = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
    self             = optional(bool)
  }))
  description = "List of ingress rules for the security group."
  default = {
    "allow_all_ingress_ssh" = {
      description = "Allow SSH access from anywhere"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    "allow_all_ingress_http" = {
      description = "Allow HTTP access from anywhere"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "egress_rules" {
  type = map(object({
    description      = optional(string)
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string))
    security_groups  = optional(list(string))
    ipv6_cidr_blocks = optional(list(string))
    self             = optional(bool)
  }))
  description = "List of egress rules for the security group."
  default = {
    "allow_all_egress" = {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
