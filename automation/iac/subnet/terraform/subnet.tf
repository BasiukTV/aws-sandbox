# Subnet configuration using Terraform

module "naming" {
    source = "../../commons/naming/terraform"

    org        = var.org
    app        = var.app
    descriptor = var.descriptor
    env        = var.env
    zone       = var.zone
}

resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr
  availability_zone = var.zone

  tags = {
    Name = var.subnet_name_override != null ? var.subnet_name_override : module.naming.subnet
  }
}
