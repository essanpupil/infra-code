output "cluster_name" {
  description = "EKS cluster name."
  value       = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  description = "Kubernetes API endpoint."
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64-encoded Kubernetes cluster CA data."
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_oidc_issuer_url" {
  description = "OIDC issuer URL for IAM Roles for Service Accounts."
  value       = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

output "node_group_names" {
  description = "Managed node group names keyed by pool name."
  value       = { for name, node_group in aws_eks_node_group.this : name => node_group.node_group_name }
}
