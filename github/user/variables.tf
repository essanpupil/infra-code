variable "github_owner" {
  description = "GitHub organization that owns the memberships."
  type        = string
}

variable "usernames" {
  description = "Twenty existing GitHub usernames to add to the organization."
  type        = set(string)

  validation {
    condition     = length(var.usernames) == 20
    error_message = "Exactly 20 existing GitHub usernames must be supplied."
  }
}

variable "role" {
  description = "Organization role for all managed users."
  type        = string
  default     = "member"

  validation {
    condition     = contains(["member", "admin"], var.role)
    error_message = "role must be member or admin."
  }
}
