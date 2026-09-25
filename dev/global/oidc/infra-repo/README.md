# GitHub Actions OIDC for `essanpupil/infra-code`

This root uses the shared GitHub Actions OIDC module to create an AWS IAM
role for workflows from:

```text
https://github.com/essanpupil/infra-code.git
```

The role trusts only the `main` branch:

```text
repo:essanpupil/infra-code:ref:refs/heads/main
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
