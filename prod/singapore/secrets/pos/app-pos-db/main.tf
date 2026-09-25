data "aws_iam_role" "pos_eng" { name = "prod-pos-eng" }
module "app_pos_db" {
  source                 = "git::https://github.com/essanpupil/infra-code.git//modules/aws/secrets"
  name                   = "prod/singapore/pos/app-pos-db"
  description            = "Production POS application database metadata."
  secret_data            = { engine = "postgres", username = "app_pos" }
  allowed_principal_arns = [data.aws_iam_role.pos_eng.arn]
  tags                   = { Environment = "prod", ManagedBy = "terraform", Application = "pos", Purpose = "database-credentials" }
}
