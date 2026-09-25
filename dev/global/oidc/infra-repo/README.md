# GitHub Actions OIDC for `essanpupil/infra-code`

This root uses the shared GitHub Actions OIDC module to create an AWS IAM
role for workflows from:

```text
https://github.com/essanpupil/infra-code.git
```

The role trusts the `main` branch and pull-request workflows:

```text
repo:essanpupil/infra-code:ref:refs/heads/main
repo:essanpupil/infra-code:pull_request
```

The module creates the account-level GitHub OIDC provider if it does not
already exist. The default role has no AWS permissions. Supply only the
least-privilege policies required by the workflows:

```hcl
managed_policy_arns = [
  "arn:aws:iam::123456789012:policy/github-actions-terraform",
]
```

Apply the state-bucket bootstrap before this root:

```sh
terraform init
terraform plan
terraform apply
```

The role ARN output should be used by GitHub Actions with
`aws-actions/configure-aws-credentials` and `role-to-assume`. No long-lived
AWS access key should be stored in GitHub.

The plan workflow needs `s3:PutObject` access to the plan prefix and read-only
AWS permissions for Terraform refresh. The apply workflow needs
`s3:GetObject` for the plan prefix and the permissions required by the
Terraform roots being applied. Configure the role ARN as the repository
variable `AWS_ROLE_ARN`; configure `TERRAFORM_PLAN_BUCKET` as
`platform-dev-terraform-state` unless the bucket name differs.
