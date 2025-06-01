module "naming" {
  source = "../../commons/naming/terraform"

  org    = var.org
  app    = var.app
  env    = var.env
  region = var.region
}

resource "aws_iam_user" "user" {
  name = module.naming.iam_user
  path = "/"
}

resource "aws_iam_access_key" "access_key" {
  count = var.make_access_key ? 1 : 0

  user = aws_iam_user.user.name
}
