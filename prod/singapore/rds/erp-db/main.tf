data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = { bucket = "platform-prod-terraform-state", key = "prod/singapore/vpc/terraform.tfstate", region = var.aws_region }
}
data "aws_iam_role" "erp_eng" { name = "prod-erp-eng" }
module "erp_db" {
  source                     = "git::https://github.com/essanpupil/infra-code.git//modules/aws/rds"
  identifier                 = "prod-erp-db"
  vpc_id                     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids                 = data.terraform_remote_state.vpc.outputs.data_subnet_ids_list
  engine                     = "postgres"
  instance_class             = "db.t4g.medium"
  allocated_storage          = 50
  max_allocated_storage      = 200
  db_name                    = "erp"
  username                   = "app_erp"
  multi_az                   = true
  backup_retention_period    = 30
  deletion_protection        = true
  skip_final_snapshot        = false
  allowed_cidr_blocks        = []
  allowed_security_group_ids = []
  tags                       = { Environment = "prod", ManagedBy = "terraform", Application = "erp", Purpose = "database" }
}
data "aws_iam_policy_document" "erp_secret_read" {
  statement {
    actions   = ["secretsmanager:DescribeSecret", "secretsmanager:GetSecretValue"]
    resources = [module.erp_db.master_user_secret_arn]
  }
}
resource "aws_iam_role_policy" "erp_secret_read" {
  name   = "prod-erp-db-master-secret-read"
  role   = data.aws_iam_role.erp_eng.name
  policy = data.aws_iam_policy_document.erp_secret_read.json
}
