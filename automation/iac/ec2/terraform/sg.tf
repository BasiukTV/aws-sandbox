// This module is used to create security groups for the EC2 instance
module "sg" {
  source = "../../security_group/terraform"

  # Only create a new security group if no existing security group ID is provided
  count = var.security_group != null && var.security_group.existingsecurity_group_id == null ? 1 : 0

  org        = var.org
  app        = var.app
  descriptor = var.descriptor
  env        = var.env
  region     = var.region

  security_group_description = var.security_group.new_security_group.security_group_description
  security_group_vpc_id      = var.security_group.new_security_group.security_group_vpc_id
  ingress_rules              = var.security_group.new_security_group.ingress_rules
  egress_rules               = var.security_group.new_security_group.egress_rules
}
