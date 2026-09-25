# Secrets Manager module

Creates an AWS Secrets Manager secret and stores a generated password together
with caller-supplied metadata. The generated password is never declared in a
Terraform variable or checked into source control.

```hcl
module "db_secret" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/aws/secrets"

  name = "platform/dev/rds"
  secret_data = {
    username = "appuser"
    engine   = "postgres"
  }
}
```

The generated password is marked sensitive, but it remains in Terraform state
because Terraform manages the secret version. Protect the state backend and
restrict access to it.

To grant read access to specific IAM principals, provide their ARNs:

```hcl
module "db_secret" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/aws/secrets"

  name                    = "platform/dev/rds"
  allowed_principal_arns  = ["arn:aws:iam::123456789012:role/app-role"]
}
```

The resource policy grants only `DescribeSecret` and `GetSecretValue`, and
explicitly denies those actions to principals outside the supplied set. An
empty set is the default and does not create a resource policy.
