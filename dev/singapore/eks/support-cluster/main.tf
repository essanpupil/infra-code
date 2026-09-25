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

data "terraform_remote_state" "erp_cluster" {
  backend = "s3"

  config = {
    bucket = "platform-dev-terraform-state"
    key    = "dev/singapore/eks/erp-cluster/terraform.tfstate"
    region = var.aws_region
  }
}

data "terraform_remote_state" "pos_cluster" {
  backend = "s3"

  config = {
    bucket = "platform-dev-terraform-state"
    key    = "dev/singapore/eks/pos-cluster/terraform.tfstate"
    region = var.aws_region
  }
}

module "eks" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/aws/eks"

  name       = local.name
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids_list

  node_pools = {
    system = {
      capacity_type              = "ON_DEMAND"
      instance_types             = ["t3.large", "t3a.large"]
      min_size                   = 3
      desired_size               = 3
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

resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "7.8.26"

  values = [yamlencode({
    server = {
      service = {
        type = "ClusterIP"
      }
    }
    configs = {
      params = {
        "server.insecure" = true
      }
    }
  })]

  depends_on = [module.eks]
}

resource "kubernetes_secret_v1" "erp_cluster" {
  metadata {
    name      = "cluster-erp"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "cluster"
    }
  }

  type = "Opaque"
  data = {
    name   = data.terraform_remote_state.erp_cluster.outputs.argocd_cluster_config.name
    server = data.terraform_remote_state.erp_cluster.outputs.argocd_cluster_config.server
    config = jsonencode({
      bearerToken = data.terraform_remote_state.erp_cluster.outputs.argocd_cluster_config.bearer_token
      tlsClientConfig = {
        insecure = false
        caData   = data.terraform_remote_state.erp_cluster.outputs.argocd_cluster_config.ca_data
      }
    })
  }

  depends_on = [helm_release.argocd]
}

resource "kubernetes_secret_v1" "pos_cluster" {
  metadata {
    name      = "cluster-pos"
    namespace = "argocd"
    labels = {
      "argocd.argoproj.io/secret-type" = "cluster"
    }
  }

  type = "Opaque"
  data = {
    name   = data.terraform_remote_state.pos_cluster.outputs.argocd_cluster_config.name
    server = data.terraform_remote_state.pos_cluster.outputs.argocd_cluster_config.server
    config = jsonencode({
      bearerToken = data.terraform_remote_state.pos_cluster.outputs.argocd_cluster_config.bearer_token
      tlsClientConfig = {
        insecure = false
        caData   = data.terraform_remote_state.pos_cluster.outputs.argocd_cluster_config.ca_data
      }
    })
  }

  depends_on = [helm_release.argocd]
}
