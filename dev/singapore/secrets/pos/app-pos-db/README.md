# POS application database secret

Creates the development POS application database secret through the shared
[`secrets` module](../../../../../modules/aws/secrets).

The secret resource policy grants `DescribeSecret` and `GetSecretValue` only to
the `pos-eng` IAM role. The generated password is stored in Terraform state,
so protect both the S3 backend and the IAM permissions used to access it.

The `pos-eng` role must exist before applying this root:

```sh
terraform init
terraform plan
terraform apply
```
