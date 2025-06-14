# Terraform configuration for creating Security Groups 

resource "aws_security_group" "sg" {
  name        = module.naming.security_group
  description = var.security_group_description
  vpc_id      = var.security_group_vpc_id

  tags = {
    Name = module.naming.security_group
  }

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      description      = ingress.value.description
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
      security_groups  = ingress.value.security_groups
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
      self             = ingress.value.self
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules

    content {
      description      = egress.value.description
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = egress.value.cidr_blocks
      security_groups  = egress.value.security_groups
      ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks
      self             = egress.value.self
    }
  }
}
