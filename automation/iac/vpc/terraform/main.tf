module "naming" {
  source = "../../commons/naming/terraform"

  org    = var.org
  app    = var.app
  env    = var.env
  region = var.region
}
