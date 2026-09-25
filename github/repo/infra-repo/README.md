# `essanpupil/infra-code` repository management

This root manages the existing
[`essanpupil/infra-code`](https://github.com/essanpupil/infra-code) repository
through the reusable GitHub repository module.

The repository must be imported into Terraform before the first plan can be
clean. Terraform cannot adopt an existing repository automatically:

```sh
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform import 'module.repository.github_repository.this' essanpupil/infra-code
terraform plan
```

The GitHub provider reads its token from `GITHUB_TOKEN`. The GitHub Actions
workflow supplies this from the `GH_TERRAFORM_TOKEN` repository secret.

The state is stored at:

```text
s3://platform-dev-terraform-state/github/repo/infra-repo/terraform.tfstate
```
