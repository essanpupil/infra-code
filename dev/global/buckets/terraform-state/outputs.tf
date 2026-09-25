output "bucket_name" {
  description = "Terraform state bucket name."
  value       = module.terraform_state.bucket_id
}

output "bucket_arn" {
  description = "Terraform state bucket ARN."
  value       = module.terraform_state.bucket_arn
}

output "bucket_region" {
  description = "Terraform state bucket region."
  value       = module.terraform_state.bucket_region
}
