locals {
  trusted_user_names = [
    for index in range(16, 31) : format("dummy-user-%02d", index)
  ]

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Purpose     = "erp-engineering"
  }
}

data "aws_iam_user" "trusted" {
  for_each = toset(local.trusted_user_names)

  user_name = each.value
}

module "erp_eng_role" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/aws/iam-role"

  name        = "erp-eng"
  description = "Assumable by the second 15 centrally managed dummy IAM users."
  trusted_principal_arns = toset([
    for user in data.aws_iam_user.trusted : user.arn
  ])
  tags = local.tags
}
