# Creatig NACLs for the VPC subnets

module "nacl" {
  for_each = var.nacl_config

  source = "../../nacl/terraform"

  org        = var.org
  app        = var.app
  env        = var.env
  region     = var.region
  descriptor = each.value.subnet_descriptor

  vpc_id = aws_vpc.vpc.id
  subnet_ids = {
    "subnet" = module.subnets[each.value.subnet_descriptor].subnet_id
  }

  allow_public_inbound_ssh   = each.value.allow_public_inbound_ssh
  allow_public_inbound_http  = each.value.allow_public_inbound_http
  allow_public_inbound_https = each.value.allow_public_inbound_https
  allow_public_inbound_ping  = each.value.allow_public_inbound_ping
  allow_public_outbound      = each.value.allow_public_outbound
  custom_inbound_rules       = each.value.custom_inbound_rules
  custom_outbound_rules      = each.value.custom_outbound_rules
}
