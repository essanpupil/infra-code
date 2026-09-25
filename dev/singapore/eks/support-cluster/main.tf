locals {
  name = "platform-dev-support"

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Team        = "platform"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "platform-dev-terraform-state"
    key    = "dev/singapore/vpc/terraform.tfstate"
    region = "ap-southeast-1"
  }
}

module "eks" {
  source = "../../../../modules/aws/eks"

  name       = local.name
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids_list

  node_pools = {
    system = {
      capacity_type              = "ON_DEMAND"
      instance_types             = ["t3.large", "t3a.large"]
      min_size                   = 2
      desired_size               = 2
      max_size                   = 4
      max_unavailable_percentage = 50
      labels = {
        "node-role.kubernetes.io/system" = "true"
      }
      taints = [{
        key    = "workload"
        value  = "system"
        effect = "NO_SCHEDULE"
      }]
    }

    workloads = {
      capacity_type              = "SPOT"
      instance_types             = ["t3.large", "t3a.large", "m5.large"]
      min_size                   = 0
      desired_size               = 1
      max_size                   = 10
      max_unavailable_percentage = 50
      labels = {
        workload = "support"
      }
    }
  }

  tags = local.tags
}
