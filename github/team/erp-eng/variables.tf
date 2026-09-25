variable "github_owner" {
  description = "GitHub organization that owns the team."
  type        = string
}

variable "usernames" {
  description = "Second half of the existing GitHub users."
  type        = set(string)

  validation {
    condition     = length(var.usernames) == 10
    error_message = "Exactly 10 existing GitHub usernames are required."
  }
}
