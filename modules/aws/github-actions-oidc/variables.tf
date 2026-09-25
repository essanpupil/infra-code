variable "role_name" {
  description = "IAM role assumed by GitHub Actions."
  type        = string
}

variable "subjects" {
  description = "Allowed GitHub OIDC subject claims, such as repo:org/name:ref:refs/heads/main."
  type        = set(string)

  validation {
    condition     = length(var.subjects) > 0
    error_message = "At least one GitHub OIDC subject is required."
  }
}

variable "path" {
  description = "IAM path for the role."
  type        = string
  default     = "/"
}

variable "description" {
  description = "IAM role description."
  type        = string
  default     = "IAM role for GitHub Actions."
}

variable "max_session_duration" {
  description = "Maximum GitHub Actions role session duration in seconds."
  type        = number
  default     = 3600
}

variable "managed_policy_arns" {
  description = "Managed policy ARNs attached to the GitHub Actions role."
  type        = set(string)
  default     = []
}

variable "inline_policy_json" {
  description = "Optional JSON IAM policy for least-privilege permissions."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to the OIDC provider and IAM role."
  type        = map(string)
  default     = {}
}
