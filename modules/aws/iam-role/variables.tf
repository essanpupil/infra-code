variable "name" {
  description = "IAM role name."
  type        = string
}

variable "path" {
  description = "IAM path for the role."
  type        = string
  default     = "/"
}

variable "description" {
  description = "IAM role description."
  type        = string
  default     = null
}

variable "trusted_principal_arns" {
  description = "IAM principal ARNs allowed to assume this role."
  type        = set(string)

  validation {
    condition     = length(var.trusted_principal_arns) > 0
    error_message = "At least one trusted principal ARN is required."
  }
}

variable "managed_policy_arns" {
  description = "Optional AWS managed or customer-managed policy ARNs attached to the role."
  type        = set(string)
  default     = []
}

variable "max_session_duration" {
  description = "Maximum role session duration in seconds."
  type        = number
  default     = 3600
}

variable "tags" {
  description = "Tags applied to the IAM role."
  type        = map(string)
  default     = {}
}
