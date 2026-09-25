locals {
  repository = "essanpupil/infra-code"

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Purpose     = "github-actions-oidc"
    Repository  = local.repository
  }
}

module "github_actions_oidc" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/aws/github-actions-oidc"

  role_name = "github-actions-infra-repo"
  subjects = [
    "repo:${local.repository}:ref:refs/heads/main",
    "repo:${local.repository}:pull_request",
  ]

  managed_policy_arns = var.managed_policy_arns
  tags                = local.tags
}
