output "team_id" {
  description = "POS engineering team ID."
  value       = module.team.team_id
}

output "team_slug" {
  description = "POS engineering team slug."
  value       = module.team.team_slug
}

output "members" {
  description = "Users assigned to the POS engineering team."
  value       = module.team.members
}
