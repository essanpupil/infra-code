output "cluster_name" { value = module.eks.cluster_name }
output "cluster_endpoint" { value = module.eks.cluster_endpoint }
output "argocd_cluster_config" {
  sensitive = true
  value = {
    name         = module.eks.cluster_name
    server       = module.eks.cluster_endpoint
    ca_data      = module.eks.cluster_certificate_authority_data
    bearer_token = try(base64decode(kubernetes_secret_v1.argocd_manager_token.data.token), null)
  }
}
