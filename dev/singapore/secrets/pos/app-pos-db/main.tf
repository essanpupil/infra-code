data "aws_iam_role" "pos_eng" {
  name = "pos-eng"
}

module "app_pos_db" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/aws/secrets"

  name        = "dev/singapore/pos/app-pos-db"
  description = "Application POS database credentials."

  secret_data = {
    engine   = "postgres"
    username = "app_pos"
  }

  allowed_principal_arns = [data.aws_iam_role.pos_eng.arn]

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Application = "pos"
    Purpose     = "database-credentials"
  }
}
