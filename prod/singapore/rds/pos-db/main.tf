data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = { bucket = "platform-prod-terraform-state", key = "prod/singapore/vpc/terraform.tfstate", region = var.aws_region }
}
data "aws_iam_role" "pos_eng" { name = "prod-pos-eng" }
module "pos_db" {
  source                     = "git::https://github.com/essanpupil/infra-code.git//modules/aws/rds"
  identifier                 = "prod-pos-db"
  vpc_id                     = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids                 = data.terraform_remote_state.vpc.outputs.data_subnet_ids_list
  engine                     = "postgres"
  instance_class             = "db.t4g.medium"
  allocated_storage          = 50
  max_allocated_storage      = 200
  db_name                    = "pos"
  username                   = "app_pos"
  multi_az                   = true
  backup_retention_period    = 30
  deletion_protection        = true
  skip_final_snapshot        = false
  allowed_cidr_blocks        = []
  allowed_security_group_ids = []
  tags                       = { Environment = "prod", ManagedBy = "terraform", Application = "pos", Purpose = "database" }
}
data "aws_iam_policy_document" "pos_secret_read" {
  statement {
    actions   = ["secretsmanager:DescribeSecret", "secretsmanager:GetSecretValue"]
    resources = [module.pos_db.master_user_secret_arn]
  }
}
resource "aws_iam_role_policy" "pos_secret_read" {
  name   = "prod-pos-db-master-secret-read"
  role   = data.aws_iam_role.pos_eng.name
  policy = data.aws_iam_policy_document.pos_secret_read.json
}
