data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "platform-dev-terraform-state"
    key    = "dev/singapore/vpc/terraform.tfstate"
    region = var.aws_region
  }
}

data "aws_iam_role" "pos_eng" {
  name = "pos-eng"
}

module "pos_db" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/aws/rds"

  identifier            = "dev-pos-db"
  vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_ids            = data.terraform_remote_state.vpc.outputs.data_subnet_ids_list
  engine                = "postgres"
  instance_class        = "db.t4g.micro"
  allocated_storage     = 20
  max_allocated_storage = 50
  db_name               = "pos"
  username              = "app_pos"

  multi_az                = false
  backup_retention_period = 7
  deletion_protection     = false
  skip_final_snapshot     = true
  apply_immediately       = false

  # No network ingress is granted by default.
  allowed_cidr_blocks        = []
  allowed_security_group_ids = []

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Application = "pos"
    Purpose     = "database"
  }
}

data "aws_iam_policy_document" "pos_secret_read" {
  statement {
    actions   = ["secretsmanager:DescribeSecret", "secretsmanager:GetSecretValue"]
    resources = [module.pos_db.master_user_secret_arn]
  }
}

resource "aws_iam_role_policy" "pos_secret_read" {
  name   = "pos-db-master-secret-read"
  role   = data.aws_iam_role.pos_eng.name
  policy = data.aws_iam_policy_document.pos_secret_read.json
}
