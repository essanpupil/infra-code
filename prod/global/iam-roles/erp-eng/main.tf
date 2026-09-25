data "aws_iam_user" "trusted" {
  for_each  = toset([for index in range(16, 31) : format("dummy-user-%02d", index)])
  user_name = each.value
}

module "erp_eng_role" {
  source                 = "git::https://github.com/essanpupil/infra-code.git//modules/aws/iam-role"
  name                   = "prod-erp-eng"
  description            = "Production ERP engineering role."
  trusted_principal_arns = toset([for user in data.aws_iam_user.trusted : user.arn])
  tags = {
    Environment = "prod"
    ManagedBy   = "terraform"
    Purpose     = "erp-engineering"
  }
}
