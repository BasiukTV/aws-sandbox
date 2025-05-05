# Calling the module to create an Internet Gateway

module "igw" {
  source = "../../igw/terraform"

  count = var.enable_internet_gateway ? 1 : 0

  org        = var.org
  app        = var.app
  descriptor = "private"
  env        = var.env
  region     = var.region

  vpc_id = aws_vpc.vpc.id
  subnet_ids = {
    "public" : module.subnets["private"].subnet_id
  }
}
