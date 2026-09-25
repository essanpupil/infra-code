output "cluster_name" {
  description = "Support EKS cluster name."
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Support EKS private API endpoint."
  value       = module.eks.cluster_endpoint
}

output "vpc_id" {
  description = "Support EKS VPC ID."
  value       = data.terraform_remote_state.vpc.outputs.vpc_id
}

output "node_group_names" {
  description = "Support EKS managed node group names."
  value       = module.eks.node_group_names
}
