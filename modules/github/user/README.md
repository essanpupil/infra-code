# GitHub user module

GitHub user accounts cannot be created or deleted by the GitHub Terraform
provider. This module manages an existing GitHub user as an organization
member and optionally grants that user direct access to repositories.

Configure the GitHub provider in the consuming root module. The provider token
should be supplied through its normal environment-variable or credentials
configuration.

```hcl
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  owner = "example-org"
}

module "platform_user" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/github/user"

  username = "engineer-example"
  role     = "member"

  repository_permissions = {
    "platform-infrastructure" = "push"
    "platform-application"     = "pull"
  }
}
```

Destroying the module removes the user's organization membership and
repository collaborator grants; it does not delete the GitHub account.

For team-based access, prefer managing GitHub teams and team-repository
permissions separately so access can be reviewed and changed collectively.
