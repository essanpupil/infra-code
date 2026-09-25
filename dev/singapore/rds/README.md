# Development PostgreSQL

This configuration uses the shared [`vpc`](../../../modules/aws/vpc),
[`secrets`](../../../modules/aws/secrets), and
[`rds`](../../../modules/aws/rds) modules to deploy a private PostgreSQL
database in Singapore (`ap-southeast-1`).

The database is placed in isolated data subnets across two Availability Zones.
Its generated password is stored in AWS Secrets Manager under
`platform-dev/rds/postgresql`.

```sh
terraform init
terraform plan
terraform apply
```

The database is intentionally development-sized and not Multi-AZ. Protect the
Terraform state because the generated password is represented in state.
