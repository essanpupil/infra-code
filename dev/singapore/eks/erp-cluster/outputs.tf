output "cluster_name" {
  description = "ERP EKS cluster name."
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "ERP EKS private API endpoint."
  value       = module.eks.cluster_endpoint
}

output "vpc_id" {
  description = "ERP EKS VPC ID."
  value       = data.terraform_remote_state.vpc.outputs.vpc_id
}

output "node_group_names" {
  description = "ERP EKS managed node group names."
  value       = module.eks.node_group_names
}

output "argocd_manager_service_account" {
  description = "Service account Argo CD uses to manage the ERP cluster."
  value       = kubernetes_service_account.argocd_manager.metadata[0].name
}

output "argocd_manager_token" {
  description = "Bearer token for Argo CD to authenticate to the ERP cluster."
  value       = try(base64decode(kubernetes_secret_v1.argocd_manager_token.data.token), null)
  sensitive   = true
}
