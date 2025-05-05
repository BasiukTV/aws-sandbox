module "naming" {
  source = "../../commons/naming/terraform"

  org        = var.org
  app        = var.app
  descriptor = var.descriptor
  env        = var.env
  region     = var.region
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name = module.naming.internet_gateway
  }
}
