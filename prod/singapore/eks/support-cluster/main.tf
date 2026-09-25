data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = { bucket = "platform-prod-terraform-state", key = "prod/singapore/vpc/terraform.tfstate", region = var.aws_region }
}
data "terraform_remote_state" "erp_cluster" {
  backend = "s3"
  config  = { bucket = "platform-prod-terraform-state", key = "prod/singapore/eks/erp-cluster/terraform.tfstate", region = var.aws_region }
}
data "terraform_remote_state" "pos_cluster" {
  backend = "s3"
  config  = { bucket = "platform-prod-terraform-state", key = "prod/singapore/eks/pos-cluster/terraform.tfstate", region = var.aws_region }
}
module "eks" {
  source     = "git::https://github.com/essanpupil/infra-code.git//modules/aws/eks"
  name       = "platform-prod-support"
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids_list
  node_pools = {
    system = {
      capacity_type              = "ON_DEMAND"
      instance_types             = ["t3.large", "t3a.large"]
      min_size                   = 3
      desired_size               = 3
      max_size                   = 6
      max_unavailable_percentage = 33
      labels                     = { "node-role.kubernetes.io/system" = "true" }
      taints                     = [{ key = "workload", value = "system", effect = "NO_SCHEDULE" }]
    }
    workloads = {
      capacity_type              = "ON_DEMAND"
      instance_types             = ["t3.large", "t3a.large"]
      min_size                   = 3
      desired_size               = 3
      max_size                   = 10
      max_unavailable_percentage = 33
      labels                     = { workload = "support" }
    }
  }
  tags = { Environment = "prod", ManagedBy = "terraform", Team = "platform" }
}
resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "7.8.26"
  values           = [yamlencode({ server = { service = { type = "ClusterIP" } } })]
}
locals {
  cluster_configs = {
    erp = data.terraform_remote_state.erp_cluster.outputs.argocd_cluster_config
    pos = data.terraform_remote_state.pos_cluster.outputs.argocd_cluster_config
  }
}
resource "kubernetes_secret_v1" "cluster" {
  for_each = local.cluster_configs
  metadata {
    name      = "cluster-${each.key}"
    namespace = "argocd"
    labels    = { "argocd.argoproj.io/secret-type" = "cluster" }
  }
  type = "Opaque"
  data = {
    name   = each.value.name
    server = each.value.server
    config = jsonencode({
      bearerToken     = each.value.bearer_token
      tlsClientConfig = { insecure = false, caData = each.value.ca_data }
    })
  }
  depends_on = [helm_release.argocd]
}
