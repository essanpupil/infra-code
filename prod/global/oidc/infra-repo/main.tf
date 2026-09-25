module "github_actions_oidc" {
  source    = "git::https://github.com/essanpupil/infra-code.git//modules/aws/github-actions-oidc"
  role_name = "github-actions-prod-infra-repo"
  subjects = [
    "repo:essanpupil/infra-code:ref:refs/heads/main",
  ]
  tags = { Environment = "prod", ManagedBy = "terraform", Purpose = "github-actions-oidc" }
}
