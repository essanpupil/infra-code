output "secret_arn" {
  description = "ARN of the Secrets Manager secret."
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_name" {
  description = "Name of the Secrets Manager secret."
  value       = aws_secretsmanager_secret.this.name
}

output "password" {
  description = "Generated password. This output is sensitive."
  value       = random_password.this.result
  sensitive   = true
}
