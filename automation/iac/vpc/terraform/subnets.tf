# Terraform configuration for creating subnets in a VPC

module "subnet_naming" {
  source = "../../commons/naming/terraform"

  for_each = var.subnets_config

  org        = var.org
  app        = var.app
  descriptor = each.value.descriptor
  env        = var.env
  zone       = each.value.zone
}

module "subnets" {
  source = "../../subnet/terraform"

  for_each = var.subnets_config

  vpc_id               = aws_vpc.vpc.id
  subnet_name_override = module.subnet_naming[each.key].subnet
  subnet_cidr          = each.value.cidr
  zone                 = each.value.zone
}