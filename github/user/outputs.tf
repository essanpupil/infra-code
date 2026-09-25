output "usernames" {
  description = "GitHub usernames managed by this configuration."
  value       = sort([for user in module.users : user.username])
}

output "membership_roles" {
  description = "Organization membership roles keyed by GitHub username."
  value       = { for username, user in module.users : username => user.membership_role }
}
