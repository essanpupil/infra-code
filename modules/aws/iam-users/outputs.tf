output "user_names" {
  description = "Names of the IAM users managed by this module."
  value       = sort([for user in aws_iam_user.this : user.name])
}

output "user_arns" {
  description = "ARNs of the IAM users managed by this module."
  value       = { for key, user in aws_iam_user.this : key => user.arn }
}
