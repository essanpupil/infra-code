# GitHub user membership management

This root manages 20 existing GitHub accounts as members of the configured
organization using the reusable [`user` module](../../modules/github/user).

GitHub accounts cannot be created by the GitHub Terraform provider. Create the
accounts manually first, then replace the placeholder usernames in
`terraform.tfvars` with their real GitHub usernames.

```sh
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with the organization and real usernames.
terraform init
terraform plan
terraform apply
```

Provide the GitHub provider token through the provider's normal environment
configuration, such as `GITHUB_TOKEN`. Do not commit `terraform.tfvars` or
credentials.
