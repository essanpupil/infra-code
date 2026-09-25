output "dummy_iam_user_names" {
  description = "Names of the 30 dummy IAM users."
  value       = module.dummy_iam_users.user_names
}

output "dummy_iam_user_arns" {
  description = "ARNs of the 30 dummy IAM users, keyed by user name."
  value       = module.dummy_iam_users.user_arns
}
