resource "github_repository" "this" {
  name        = var.name
  description = var.description
  visibility  = var.visibility

  homepage_url                = var.homepage_url
  has_issues                  = var.has_issues
  has_projects                = var.has_projects
  has_wiki                    = var.has_wiki
  has_discussions             = var.has_discussions
  has_downloads               = var.has_downloads
  is_template                 = var.is_template
  allow_merge_commit          = var.allow_merge_commit
  allow_squash_merge          = var.allow_squash_merge
  allow_rebase_merge          = var.allow_rebase_merge
  allow_auto_merge            = var.allow_auto_merge
  delete_branch_on_merge      = var.delete_branch_on_merge
  squash_merge_commit_title   = var.squash_merge_commit_title
  squash_merge_commit_message = var.squash_merge_commit_message
  archived                    = var.archived
  auto_init                   = var.auto_init
  topics                      = var.topics

  dynamic "template" {
    for_each = var.template == null ? [] : [var.template]
    content {
      owner      = template.value.owner
      repository = template.value.repository
    }
  }

  dynamic "security_and_analysis" {
    for_each = var.enable_advanced_security ? [true] : []
    content {
      advanced_security {
        status = "enabled"
      }
      secret_scanning {
        status = "enabled"
      }
      secret_scanning_push_protection {
        status = "enabled"
      }
    }
  }
}

resource "github_repository_vulnerability_alerts" "this" {
  count      = var.enable_vulnerability_alerts ? 1 : 0
  repository = github_repository.this.name
}

resource "github_branch_protection_v3" "this" {
  count = var.branch_protection == null ? 0 : 1

  repository                      = github_repository.this.name
  branch                          = var.branch_protection.pattern
  enforce_admins                  = var.branch_protection.enforce_admins
  require_conversation_resolution = var.branch_protection.require_conversation_resolution

  dynamic "required_status_checks" {
    for_each = var.branch_protection.required_status_checks == null ? [] : [var.branch_protection.required_status_checks]
    content {
      strict   = required_status_checks.value.strict
      contexts = required_status_checks.value.contexts
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = var.branch_protection.required_pull_request_reviews == null ? [] : [var.branch_protection.required_pull_request_reviews]
    content {
      dismiss_stale_reviews           = required_pull_request_reviews.value.dismiss_stale_reviews
      require_code_owner_reviews      = required_pull_request_reviews.value.require_code_owner_reviews
      required_approving_review_count = required_pull_request_reviews.value.required_approving_review_count
    }
  }

  restrictions {
    users = var.branch_protection.restrictions.users
    teams = var.branch_protection.restrictions.teams
    apps  = var.branch_protection.restrictions.apps
  }
}
