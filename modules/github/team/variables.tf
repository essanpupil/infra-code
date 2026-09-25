variable "name" {
  description = "GitHub team name."
  type        = string
}

variable "description" {
  description = "GitHub team description."
  type        = string
  default     = null
}

variable "privacy" {
  description = "Team visibility."
  type        = string
  default     = "closed"

  validation {
    condition     = contains(["closed", "secret"], var.privacy)
    error_message = "privacy must be closed or secret."
  }
}

variable "parent_team_id" {
  description = "Optional parent team ID for nested teams."
  type        = number
  default     = null
}

variable "members" {
  description = "Map of GitHub usernames to team roles."
  type        = map(string)
  default     = {}

  validation {
    condition = alltrue([
      for role in values(var.members) :
      contains(["member", "maintainer"], role)
    ])
    error_message = "Team member roles must be member or maintainer."
  }
}

variable "repository_permissions" {
  description = "Map of repository names to team permissions."
  type        = map(string)
  default     = {}

  validation {
    condition = alltrue([
      for permission in values(var.repository_permissions) :
      contains(["pull", "triage", "push", "maintain", "admin"], permission)
    ])
    error_message = "Repository permissions must be pull, triage, push, maintain, or admin."
  }
}
