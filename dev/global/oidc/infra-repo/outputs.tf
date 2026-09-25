output "role_name" {
  description = "IAM role assumed by the infra-code GitHub Actions workflow."
  value       = module.github_actions_oidc.role_name
}

output "role_arn" {
  description = "IAM role ARN for GitHub Actions."
  value       = module.github_actions_oidc.role_arn
}

output "oidc_provider_arn" {
  description = "GitHub Actions OIDC provider ARN."
  value       = module.github_actions_oidc.oidc_provider_arn
}
