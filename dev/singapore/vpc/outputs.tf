output "vpc_id" {
  description = "Shared development VPC ID."
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "Shared development VPC CIDR block."
  value       = module.vpc.vpc_cidr_block
}

output "availability_zones" {
  description = "Availability Zones used by the shared VPC."
  value       = module.vpc.availability_zones
}

output "private_subnet_ids_list" {
  description = "Shared private subnet IDs in Availability Zone order."
  value       = module.vpc.private_subnet_ids_list
}

output "data_subnet_ids_list" {
  description = "Shared data subnet IDs in Availability Zone order."
  value       = module.vpc.data_subnet_ids_list
}
