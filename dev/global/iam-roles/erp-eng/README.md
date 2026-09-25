# `erp-eng` IAM role

Creates the global IAM role `erp-eng` and allows the second half of the
centrally managed dummy users (`dummy-user-16` through `dummy-user-30`) to
assume it.

The users must already exist in the AWS account through the central IAM-user
configuration before this root is applied. The role has no permissions
attached by default; add managed policy ARNs only after defining the required
least-privilege access.

```sh
terraform init
terraform plan
terraform apply
```
