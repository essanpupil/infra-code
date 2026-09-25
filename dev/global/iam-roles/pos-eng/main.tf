locals {
  trusted_user_names = [
    for index in range(1, 16) : format("dummy-user-%02d", index)
  ]

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Purpose     = "pos-engineering"
  }
}

data "aws_iam_user" "trusted" {
  for_each = toset(local.trusted_user_names)

  user_name = each.value
}

module "pos_eng_role" {
  source = "../../../../modules/aws/iam-role"

  name        = "pos-eng"
  description = "Assumable by the first 15 centrally managed dummy IAM users."
  trusted_principal_arns = toset([
    for user in data.aws_iam_user.trusted : user.arn
  ])
  tags = local.tags
}
