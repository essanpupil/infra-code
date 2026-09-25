output "team_id" {
  description = "GitHub team ID."
  value       = github_team.this.id
}

output "team_node_id" {
  description = "GitHub team node ID."
  value       = github_team.this.node_id
}

output "team_name" {
  description = "GitHub team name."
  value       = github_team.this.name
}

output "team_slug" {
  description = "GitHub team slug."
  value       = github_team.this.slug
}

output "members" {
  description = "Configured team members and roles."
  value       = { for username, membership in github_team_membership.this : username => membership.role }
}

output "repository_permissions" {
  description = "Configured repository permissions."
  value       = { for repository, access in github_team_repository.this : repository => access.permission }
}
