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
  description = "The descriptor of the resource."
  default     = null
}

variable "env" {
  type        = string
  description = "Optional name of the deployment environment (like dev, test, prod, etc.)"
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

# Variables for EC2 configuration
variable "ami" {
  type        = string
  description = "The AMI ID to use for the EC2 instance."
  default     = "ami-09e6f87a47903347c" # Amazon Linux 2023 kernel-6.1 AMI
}

variable "instance_type" {
  type        = string
  description = "The instance type for the EC2 instance."
  default     = "t2.micro"
}

variable "associate_public_ip" {
  type        = bool
  description = "Whether to associate a public IP address with the EC2 instance."
  default     = true
}

variable "security_group" {
  description = "Optional security group configuration. Provide either existing security group ID or create a new one with rules."
  type = object({
    # Optional existing security group ID to use. If provided, a new security group will not be created.
    existingsecurity_group_id = optional(string)

    # Optional description for the security group. This will not be used if security_group_id is provided.
    new_security_group = optional(object({
      security_group_description = optional(string)
      security_group_vpc_id      = optional(string)
      ingress_rules = optional(map(object({
        description      = optional(string)
        from_port        = number
        to_port          = number
        protocol         = string
        cidr_blocks      = optional(list(string))
        security_groups  = optional(list(string))
        ipv6_cidr_blocks = optional(list(string))
        self             = optional(bool)
      })))
      egress_rules = optional(map(object({
        description      = optional(string)
        from_port        = number
        to_port          = number
        protocol         = string
        cidr_blocks      = optional(list(string))
        security_groups  = optional(list(string))
        ipv6_cidr_blocks = optional(list(string))
        self             = optional(bool)
      })))
    }))
  })
  default = {
    existingsecurity_group_id = null

    new_security_group = {
      security_group_description = null
      security_group_vpc_id      = null
      ingress_rules = {
        "allow_ssh" = {
          description = "Allow SSH access from anywhere"
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        "allow_http" = {
          description = "Allow HTTP access from anywhere"
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
      }
      egress_rules = {
        "allow_all" = {
          description = "Allow all outbound traffic"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }
}
