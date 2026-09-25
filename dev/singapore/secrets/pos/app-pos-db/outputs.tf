output "secret_arn" {
  description = "ARN of the POS application database secret."
  value       = module.app_pos_db.secret_arn
}

output "secret_name" {
  description = "Name of the POS application database secret."
  value       = module.app_pos_db.secret_name
}
