data "aws_iam_role" "erp_eng" { name = "prod-erp-eng" }
module "app_erp_db" {
  source                 = "git::https://github.com/essanpupil/infra-code.git//modules/aws/secrets"
  name                   = "prod/singapore/erp/app-erp-db"
  description            = "Production ERP application database metadata."
  secret_data            = { engine = "postgres", username = "app_erp" }
  allowed_principal_arns = [data.aws_iam_role.erp_eng.arn]
  tags                   = { Environment = "prod", ManagedBy = "terraform", Application = "erp", Purpose = "database-credentials" }
}
