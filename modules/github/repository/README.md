# GitHub repository module

This module manages a GitHub repository, optional security settings, and
optional protection for one branch. Configure the GitHub provider in the
consuming root module; the provider token should be supplied through the
provider's normal environment-variable or credentials configuration.

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

module "repository" {
  source = "./modules/github/repository"

  name        = "platform-infrastructure"
  description = "Infrastructure as code"
  visibility  = "private"
  topics      = ["terraform", "infrastructure"]

  enable_vulnerability_alerts = true

  branch_protection = {
    pattern = "main"
    required_status_checks = {
      contexts = ["ci / test"]
    }
    required_pull_request_reviews = {
      required_approving_review_count = 2
    }
  }
}
```

Branch protection is omitted when `branch_protection = null`. The module does
not manage collaborators, teams, deploy keys, webhooks, or repository secrets;
those can be managed by separate modules to keep access boundaries explicit.
