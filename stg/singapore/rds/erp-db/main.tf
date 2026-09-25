data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = { bucket = "platform-stg-terraform-state", key = "stg/singapore/vpc/terraform.tfstate", region = var.aws_region }
}
data "aws_iam_role" "erp_eng" { name = "stg-erp-eng" }
module "erp_db" {
  source                     = "git::https://github.com/essanpupil/infra-code.git//modules/aws/rds"
  identifier                 = "stg-erp-db"
  vpc_id                     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids                 = data.terraform_remote_state.vpc.outputs.data_subnet_ids_list
  engine                     = "postgres"
  instance_class             = "db.t4g.micro"
  allocated_storage          = 20
  max_allocated_storage      = 50
  db_name                    = "erp"
  username                   = "app_erp"
  multi_az                   = false
  backup_retention_period    = 7
  deletion_protection        = false
  skip_final_snapshot        = true
  allowed_cidr_blocks        = []
  allowed_security_group_ids = []
  tags                       = { Environment = "stg", ManagedBy = "terraform", Application = "erp", Purpose = "database" }
}
data "aws_iam_policy_document" "erp_secret_read" {
  statement {
    actions   = ["secretsmanager:DescribeSecret", "secretsmanager:GetSecretValue"]
    resources = [module.erp_db.master_user_secret_arn]
  }
}
resource "aws_iam_role_policy" "erp_secret_read" {
  name   = "stg-erp-db-master-secret-read"
  role   = data.aws_iam_role.erp_eng.name
  policy = data.aws_iam_policy_document.erp_secret_read.json
}
