output "db_instance_arn" {
  description = "RDS instance ARN."
  value       = aws_db_instance.this.arn
}

output "db_instance_endpoint" {
  description = "RDS endpoint including port."
  value       = aws_db_instance.this.endpoint
}

output "db_address" {
  description = "RDS hostname."
  value       = aws_db_instance.this.address
}

output "db_port" {
  description = "RDS port."
  value       = aws_db_instance.this.port
}

output "security_group_id" {
  description = "RDS security group ID."
  value       = aws_security_group.this.id
}
