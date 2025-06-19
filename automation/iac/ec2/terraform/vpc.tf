module "vpc" {
  source = "../../vpc/terraform"

  count = var.subnet_config.existing_subnet_id == null ? 1 : 0

  org    = var.org
  app    = var.app
  env    = var.env
  region = var.region
}