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
