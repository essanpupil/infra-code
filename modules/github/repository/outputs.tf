output "repository_id" {
  description = "GitHub repository node ID."
  value       = github_repository.this.node_id
}

output "repository_name" {
  description = "GitHub repository name."
  value       = github_repository.this.name
}

output "repository_full_name" {
  description = "GitHub repository full name."
  value       = github_repository.this.full_name
}

output "repository_html_url" {
  description = "GitHub repository URL."
  value       = github_repository.this.html_url
}
