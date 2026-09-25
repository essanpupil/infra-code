data "aws_iam_user" "trusted" {
  for_each  = toset([for index in range(1, 16) : format("dummy-user-%02d", index)])
  user_name = each.value
}

module "pos_eng_role" {
  source                 = "git::https://github.com/essanpupil/infra-code.git//modules/aws/iam-role"
  name                   = "stg-pos-eng"
  description            = "Staging POS engineering role."
  trusted_principal_arns = toset([for user in data.aws_iam_user.trusted : user.arn])
  tags = {
    Environment = "stg"
    ManagedBy   = "terraform"
    Purpose     = "pos-engineering"
  }
}
