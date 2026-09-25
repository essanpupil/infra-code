output "repository_id" {
  description = "GitHub repository node ID."
  value       = module.repository.repository_id
}

output "repository_full_name" {
  description = "GitHub repository full name."
  value       = module.repository.repository_full_name
}

output "repository_html_url" {
  description = "GitHub repository URL."
  value       = module.repository.repository_html_url
}
