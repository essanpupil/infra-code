output "team_id" {
  description = "ERP engineering team ID."
  value       = module.team.team_id
}

output "team_slug" {
  description = "ERP engineering team slug."
  value       = module.team.team_slug
}

output "members" {
  description = "Users assigned to the ERP engineering team."
  value       = module.team.members
}
