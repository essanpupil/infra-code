data "aws_iam_role" "erp_eng" {
  name = "erp-eng"
}

module "app_erp_db" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/aws/secrets"

  name        = "dev/singapore/erp/app-erp-db"
  description = "Application ERP database credentials."

  secret_data = {
    engine   = "postgres"
    username = "app_erp"
  }

  allowed_principal_arns = [data.aws_iam_role.erp_eng.arn]

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Application = "erp"
    Purpose     = "database-credentials"
  }
}
