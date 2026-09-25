# Terraform GitHub resource workflow

The `terraform-github-plan.yml` and `terraform-github-apply.yml` workflows
manage Terraform roots under `github/`.

The plan workflow runs when a pull request is opened. The apply workflow runs
when a matching pull request is merged, or manually through `workflow_dispatch`.

Configure these GitHub repository secrets:

- `GH_TERRAFORM_TOKEN`: a fine-grained GitHub token with access to the organization
  and repositories managed by Terraform.
- `GITHUB_OWNER`: the GitHub organization name.

The workflow also uses the existing `AWS_ROLE_ARN` repository variable and
S3 plan bucket configuration to store the binary Terraform plan between the
plan and apply runs. The `terraform-github-apply` environment should require
review before applying merged changes.
