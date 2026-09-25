output "username" {
  description = "Managed GitHub username."
  value       = github_membership.this.username
}

output "membership_role" {
  description = "Organization membership role."
  value       = github_membership.this.role
}

output "repository_permissions" {
  description = "Repository permissions managed for the user."
  value       = { for repository, collaborator in github_repository_collaborator.this : repository => collaborator.permission }
}
