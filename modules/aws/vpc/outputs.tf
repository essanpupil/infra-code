output "vpc_id" {
  description = "VPC ID."
  value       = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "VPC IPv4 CIDR block."
  value       = aws_vpc.this.cidr_block
}

output "availability_zones" {
  description = "Availability Zones used by this VPC."
  value       = var.availability_zones
}

output "public_subnet_ids" {
  description = "Public subnet IDs keyed by Availability Zone index."
  value       = { for key, subnet in aws_subnet.public : key => subnet.id }
}

output "private_subnet_ids" {
  description = "Private subnet IDs keyed by Availability Zone index."
  value       = { for key, subnet in aws_subnet.private : key => subnet.id }
}

output "public_subnet_ids_list" {
  description = "Public subnet IDs in Availability Zone input order."
  value       = [for key in keys(local.az_indexes) : aws_subnet.public[key].id]
}

output "private_subnet_ids_list" {
  description = "Private subnet IDs in Availability Zone input order."
  value       = [for key in keys(local.az_indexes) : aws_subnet.private[key].id]
}

output "data_subnet_ids" {
  description = "Data subnet IDs keyed by Availability Zone index."
  value       = { for key, subnet in aws_subnet.data : key => subnet.id }
}

output "data_subnet_ids_list" {
  description = "Data subnet IDs in Availability Zone input order."
  value       = length(var.data_subnet_cidrs) > 0 ? [for key in keys(local.az_indexes) : aws_subnet.data[key].id] : []
}

output "nat_gateway_ids" {
  description = "NAT gateway IDs keyed by Availability Zone index."
  value       = { for key, nat in aws_nat_gateway.this : key => nat.id }
}
