# IAM users module

This module creates one `aws_iam_user` resource for each name in `user_names`.
It does not create access keys, console login profiles, groups, or policies.
Those capabilities should be added only when required and managed separately.

```hcl
module "iam_users" {
  source = "./modules/aws/iam-users"

  user_names = ["dummy-user-01", "dummy-user-02"]
  tags = {
    ManagedBy = "terraform"
  }
}
```

Run `terraform init` and `terraform validate` from the root configuration that
consumes this module.
