# Central
Central folder is used to stored terraform configuration for central aws organization account.
This central account is only used to configure AWS Organization, AWS IAM User, and other administrative resource required for AWS Organizations administrative.

## Dummy IAM users

The configuration in this folder creates 30 IAM users named
`dummy-user-01` through `dummy-user-30` using the reusable
[`iam-users`](../modules/aws/iam-users) module.

No access keys, console passwords, groups, or policies are created. Configure
credentials and permissions separately only if they are explicitly required.

```sh
terraform init
terraform plan
terraform apply
```

Set `-var='aws_region=<region>'` when a region other than `ap-southeast-1` is
required. AWS credentials must be configured through the standard AWS provider
credential chain before running Terraform.
