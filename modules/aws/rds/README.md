# RDS module

Creates a private, encrypted RDS instance in a supplied subnet group and
security group. RDS manages the master user password in Secrets Manager through
`manage_master_user_password = true`.

The module supports PostgreSQL, MySQL-compatible engines, storage autoscaling,
Multi-AZ, backups, maintenance windows, and CIDR/security-group ingress. The
RDS-managed secret ARN is exposed for granting narrowly scoped IAM access.
