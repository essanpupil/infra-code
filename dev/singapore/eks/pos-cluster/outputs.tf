output "cluster_name" {
  description = "POS EKS cluster name."
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "POS EKS private API endpoint."
  value       = module.eks.cluster_endpoint
}

output "vpc_id" {
  description = "POS EKS VPC ID."
  value       = data.terraform_remote_state.vpc.outputs.vpc_id
}

output "node_group_names" {
  description = "POS EKS managed node group names."
  value       = module.eks.node_group_names
}
