output "db_instance_arn" {
  description = "POS RDS instance ARN."
  value       = module.pos_db.db_instance_arn
}

output "db_address" {
  description = "POS PostgreSQL hostname."
  value       = module.pos_db.db_address
}

output "db_port" {
  description = "POS PostgreSQL port."
  value       = module.pos_db.db_port
}

output "security_group_id" {
  description = "POS RDS security group ID."
  value       = module.pos_db.security_group_id
}
