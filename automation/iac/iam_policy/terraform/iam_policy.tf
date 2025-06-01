module "naming" {
  source = "../../commons/naming/terraform"

  org    = var.org
  app    = var.app
  env    = var.env
  region = var.region
}

resource "aws_iam_policy" "aimpol" {
  name        = module.naming.iam_policy
  description = var.policy_description

  policy = data.aws_iam_policy_document.aimpol_doc.json
}

# Data source for the IAM policy document
data "aws_iam_policy_document" "aimpol_doc" {
  statement {
    effect    = "Allow"
    actions   = var.policy_statement.actions
    resources = var.policy_statement.resources
  }
}

resource "aws_iam_user_policy_attachment" "test-attach" {
  # Only attach the IAM policy to the user if the user name is provided
  count = var.iam_user_name == null ? 0 : 1

  user       = var.iam_user_name
  policy_arn = aws_iam_policy.aimpol.arn
}
