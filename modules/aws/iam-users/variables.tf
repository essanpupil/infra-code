variable "user_names" {
  description = "IAM user names to create."
  type        = set(string)

  validation {
    condition = alltrue([
      for name in var.user_names : can(regex("^[A-Za-z0-9+=,.@_-]{1,64}$", name))
    ])
    error_message = "Each IAM user name must be 1-64 characters and contain only IAM-supported characters."
  }
}

variable "path" {
  description = "IAM path for the users."
  type        = string
  default     = "/"
}

variable "force_destroy" {
  description = "Allow users and their login profiles or access keys to be deleted during destroy."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to every IAM user."
  type        = map(string)
  default     = {}
}
