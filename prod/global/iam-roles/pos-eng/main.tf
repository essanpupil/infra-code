data "aws_iam_user" "trusted" {
  for_each  = toset([for index in range(1, 16) : format("dummy-user-%02d", index)])
  user_name = each.value
}

module "pos_eng_role" {
  source                 = "git::https://github.com/essanpupil/infra-code.git//modules/aws/iam-role"
  name                   = "prod-pos-eng"
  description            = "Production POS engineering role."
  trusted_principal_arns = toset([for user in data.aws_iam_user.trusted : user.arn])
  tags = {
    Environment = "prod"
    ManagedBy   = "terraform"
    Purpose     = "pos-engineering"
  }
}
