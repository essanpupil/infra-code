variable "name" {
  description = "GitHub repository name."
  type        = string
}

variable "description" {
  description = "GitHub repository description."
  type        = string
  default     = null
}

variable "visibility" {
  description = "Repository visibility."
  type        = string
  default     = "private"

  validation {
    condition     = contains(["private", "public", "internal"], var.visibility)
    error_message = "visibility must be private, public, or internal."
  }
}

variable "homepage_url" {
  description = "Optional repository homepage URL."
  type        = string
  default     = null
}

variable "has_issues" {
  description = "Enable GitHub Issues."
  type        = bool
  default     = true
}

variable "has_projects" {
  description = "Enable GitHub Projects."
  type        = bool
  default     = false
}

variable "has_wiki" {
  description = "Enable the repository wiki."
  type        = bool
  default     = false
}

variable "has_discussions" {
  description = "Enable GitHub Discussions."
  type        = bool
  default     = false
}

variable "has_downloads" {
  description = "Enable repository downloads."
  type        = bool
  default     = false
}

variable "is_template" {
  description = "Mark the repository as a template."
  type        = bool
  default     = false
}

variable "allow_merge_commit" {
  description = "Allow merge commits."
  type        = bool
  default     = true
}

variable "allow_squash_merge" {
  description = "Allow squash merges."
  type        = bool
  default     = true
}

variable "allow_rebase_merge" {
  description = "Allow rebase merges."
  type        = bool
  default     = false
}

variable "allow_auto_merge" {
  description = "Allow pull requests to be automatically merged."
  type        = bool
  default     = false
}

variable "delete_branch_on_merge" {
  description = "Delete head branches after pull requests are merged."
  type        = bool
  default     = true
}

variable "squash_merge_commit_title" {
  description = "Title behavior for squash merges."
  type        = string
  default     = "COMMIT_OR_PR_TITLE"
}

variable "squash_merge_commit_message" {
  description = "Message behavior for squash merges."
  type        = string
  default     = "COMMIT_MESSAGES"
}

variable "archived" {
  description = "Archive the repository."
  type        = bool
  default     = false
}

variable "auto_init" {
  description = "Create an initial commit with a README."
  type        = bool
  default     = true
}

variable "topics" {
  description = "Repository topics."
  type        = set(string)
  default     = []
}

variable "template" {
  description = "Optional GitHub template repository."
  type = object({
    owner      = string
    repository = string
  })
  default = null
}

variable "enable_advanced_security" {
  description = "Enable GitHub Advanced Security and secret scanning."
  type        = bool
  default     = false
}

variable "enable_vulnerability_alerts" {
  description = "Enable Dependabot vulnerability alerts."
  type        = bool
  default     = true
}

variable "branch_protection" {
  description = "Optional protection configuration for one branch."
  type = object({
    pattern                         = string
    enforce_admins                  = optional(bool, false)
    require_conversation_resolution = optional(bool, true)
    required_status_checks = optional(object({
      strict   = optional(bool, true)
      contexts = optional(list(string), [])
    }))
    required_pull_request_reviews = optional(object({
      dismiss_stale_reviews           = optional(bool, true)
      require_code_owner_reviews      = optional(bool, false)
      required_approving_review_count = optional(number, 1)
    }))
    restrictions = optional(object({
      users = optional(list(string), [])
      teams = optional(list(string), [])
      apps  = optional(list(string), [])
    }), {})
  })
  default = null
}
