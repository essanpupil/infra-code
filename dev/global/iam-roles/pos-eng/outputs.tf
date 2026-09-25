output "role_name" {
  description = "IAM role name."
  value       = module.pos_eng_role.role_name
}

output "role_arn" {
  description = "IAM role ARN."
  value       = module.pos_eng_role.role_arn
}

output "trusted_user_names" {
  description = "Centrally defined users trusted to assume the role."
  value       = local.trusted_user_names
}
