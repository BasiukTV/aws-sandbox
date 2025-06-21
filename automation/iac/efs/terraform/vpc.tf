# This module creates a VPC for the EFS mount targets if the new_basic_vpc variable is set to true.
module "vpc" {
  source = "../../vpc/terraform"

  count = var.mount_subnets.new_basic_vpc ? 1 : 0

  org    = var.org
  app    = var.app
  env    = var.env
  region = var.region
}
