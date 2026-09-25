output "db_instance_arn" {
  description = "ERP RDS instance ARN."
  value       = module.erp_db.db_instance_arn
}

output "db_address" {
  description = "ERP PostgreSQL hostname."
  value       = module.erp_db.db_address
}

output "db_port" {
  description = "ERP PostgreSQL port."
  value       = module.erp_db.db_port
}

output "security_group_id" {
  description = "ERP RDS security group ID."
  value       = module.erp_db.security_group_id
}
