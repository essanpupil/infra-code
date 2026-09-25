module "github_actions_oidc" {
  source    = "git::https://github.com/essanpupil/infra-code.git//modules/aws/github-actions-oidc"
  role_name = "github-actions-stg-infra-repo"
  subjects = [
    "repo:essanpupil/infra-code:ref:refs/heads/main",
    "repo:essanpupil/infra-code:pull_request",
  ]
  tags = { Environment = "stg", ManagedBy = "terraform", Purpose = "github-actions-oidc" }
}
