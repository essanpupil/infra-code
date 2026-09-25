output "secret_arn" {
  description = "ARN of the ERP application database secret."
  value       = module.app_erp_db.secret_arn
}

output "secret_name" {
  description = "Name of the ERP application database secret."
  value       = module.app_erp_db.secret_name
}
