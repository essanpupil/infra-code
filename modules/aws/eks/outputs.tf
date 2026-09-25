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

output "karpenter_interruption_queue_name" {
  description = "SQS queue name used by Karpenter interruption handling."
  value       = var.enable_karpenter ? aws_sqs_queue.karpenter_interruption[0].name : null
}

output "karpenter_controller_role_arn" {
  description = "IRSA role ARN for the Karpenter controller."
  value       = var.enable_karpenter ? aws_iam_role.karpenter_controller[0].arn : null
}

output "karpenter_node_role_name" {
  description = "Node IAM role name to use in Karpenter EC2NodeClass resources."
  value       = var.enable_karpenter ? aws_iam_role.nodes.name : null
}
