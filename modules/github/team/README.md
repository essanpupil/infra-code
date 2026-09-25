# GitHub team module

This module manages a GitHub organization team, its members, and its
repository permissions. Configure the GitHub provider in the consuming root
module; the provider token should be supplied through the provider's normal
environment-variable or credentials configuration.

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

module "platform_team" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/github/team"

  name        = "platform-engineering"
  description = "Platform engineering team"
  privacy     = "closed"

  members = {
    "engineer-example" = "maintainer"
    "developer-example" = "member"
  }

  repository_permissions = {
    "platform-infrastructure" = "push"
    "platform-application"     = "maintain"
  }
}
```

Destroying the module removes the team, its team memberships, and its
team-repository grants. It does not delete the GitHub user accounts or
repositories.
