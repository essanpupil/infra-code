# POS PostgreSQL database

Deploys the development POS PostgreSQL instance through the shared
[`rds` module](../../../../../modules/aws/rds).

RDS manages the master database password directly in its own Secrets Manager
secret. An inline IAM policy grants only the `pos-eng` role
`DescribeSecret` and `GetSecretValue` access to that RDS-managed secret.

The RDS security group has no network ingress by default. This prevents
unintended database access; add an approved application security group through
the RDS module only when a workload needs connectivity.

Apply dependencies in this order:

```sh
cd dev/singapore/vpc
terraform apply

cd ../../rds/pos-db
terraform init
terraform plan
terraform apply
```

The database is development-sized and not Multi-AZ. The generated password is
represented in the Secrets Manager and RDS Terraform states, so protect both
S3 state objects.
