module "repository" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/github/repository"

  name        = "infra-code"
  description = "Infrastructure as code for AWS and GitHub."
  visibility  = "public"

  has_issues      = true
  has_projects    = false
  has_wiki        = false
  has_discussions = false

  allow_merge_commit          = true
  allow_squash_merge          = true
  allow_rebase_merge          = false
  allow_auto_merge            = false
  delete_branch_on_merge      = true
  squash_merge_commit_title   = "COMMIT_OR_PR_TITLE"
  squash_merge_commit_message = "COMMIT_MESSAGES"

  auto_init                   = false
  enable_advanced_security    = false
  enable_vulnerability_alerts = true

  topics = [
    "aws",
    "eks",
    "terraform",
  ]
}
