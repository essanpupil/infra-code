# RDS module

Creates a private, encrypted RDS instance in a supplied subnet group and
security group. The caller supplies the password, normally from the
[`secrets`](../secrets) module.

The module supports PostgreSQL, MySQL-compatible engines, storage autoscaling,
Multi-AZ, backups, maintenance windows, and CIDR/security-group ingress.
