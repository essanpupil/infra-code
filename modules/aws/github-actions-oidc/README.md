# GitHub Actions OIDC module

Creates the AWS IAM OIDC provider for GitHub Actions and an IAM role that can
be assumed only by the configured GitHub OIDC subject claims. No long-lived
AWS access keys are required in GitHub.

Use exact subjects whenever possible:

```hcl
subjects = [
  "repo:example-org/infra-code:ref:refs/heads/main",
]
```

Pull-request workflows can use a separate subject such as
`repo:example-org/infra-code:pull_request`. Avoid broad subjects such as
`repo:example-org/*` unless that trust boundary is intentional.

Permissions are deliberately opt-in through `managed_policy_arns` or
`inline_policy_json`. For Terraform execution, prefer a narrowly scoped
deployment role and a separate state-access policy rather than attaching
`AdministratorAccess`.

The module creates the account-level OIDC provider. Instantiate it once per
AWS account and reuse the resulting provider/role pattern for additional
repositories.
