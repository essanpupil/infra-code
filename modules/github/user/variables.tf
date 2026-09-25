variable "username" {
  description = "Existing GitHub username to manage."
  type        = string
}

variable "role" {
  description = "Organization membership role."
  type        = string
  default     = "member"

  validation {
    condition     = contains(["member", "admin"], var.role)
    error_message = "role must be member or admin."
  }
}

variable "repository_permissions" {
  description = "Map of repository names to collaborator permissions."
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
