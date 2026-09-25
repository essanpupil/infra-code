data "aws_iam_role" "erp_eng" { name = "stg-erp-eng" }
module "app_erp_db" {
  source                 = "git::https://github.com/essanpupil/infra-code.git//modules/aws/secrets"
  name                   = "stg/singapore/erp/app-erp-db"
  description            = "Staging ERP application database metadata."
  secret_data            = { engine = "postgres", username = "app_erp" }
  allowed_principal_arns = [data.aws_iam_role.erp_eng.arn]
  tags                   = { Environment = "stg", ManagedBy = "terraform", Application = "erp", Purpose = "database-credentials" }
}
