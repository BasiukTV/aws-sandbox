# Just the naming module for the NACLs

module "naming" {
  source = "../../commons/naming/terraform"

  org        = var.org
  app        = var.app
  descriptor = var.descriptor
  env        = var.env
  region     = var.region
}
