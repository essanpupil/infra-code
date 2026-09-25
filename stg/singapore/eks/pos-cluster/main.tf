data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "platform-stg-terraform-state"
    key    = "stg/singapore/vpc/terraform.tfstate"
    region = var.aws_region
  }
}
module "eks" {
  source     = "git::https://github.com/essanpupil/infra-code.git//modules/aws/eks"
  name       = "platform-stg-pos"
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids_list
  node_pools = {
    system = {
      capacity_type              = "ON_DEMAND"
      instance_types             = ["m7i.large", "m6i.large"]
      min_size                   = 3
      desired_size               = 3
      max_size                   = 6
      max_unavailable_percentage = 33
      labels                     = { "node-role.kubernetes.io/system" = "true" }
      taints                     = [{ key = "workload", value = "system", effect = "NO_SCHEDULE" }]
    }
    workloads = {
      capacity_type              = "SPOT"
      instance_types             = ["m7i.large", "m6i.large", "m5.large"]
      min_size                   = 0
      desired_size               = 2
      max_size                   = 20
      max_unavailable_percentage = 50
      labels                     = { workload = "pos" }
    }
  }
  tags = { Environment = "stg", ManagedBy = "terraform", Team = "pos" }
}
