variable "name" {
  description = "Secrets Manager secret name."
  type        = string
}

variable "description" {
  description = "Description for the secret."
  type        = string
  default     = null
}

variable "secret_data" {
  description = "Non-password key/value data to store in the secret."
  type        = map(string)
  default     = {}
}

variable "password_length" {
  description = "Generated password length."
  type        = number
  default     = 32

  validation {
    condition     = var.password_length >= 16
    error_message = "password_length must be at least 16 characters."
  }
}

variable "override_special" {
  description = "Special characters allowed in the generated password."
  type        = string
  default     = "!#$%&*()-_=+[]{}<>:?"
}

variable "recovery_window_in_days" {
  description = "Number of days before the secret can be deleted."
  type        = number
  default     = 7
}

variable "kms_key_id" {
  description = "Optional customer-managed KMS key ID or ARN."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to the secret."
  type        = map(string)
  default     = {}
}

variable "allowed_principal_arns" {
  description = "IAM principal ARNs allowed to read the secret. An empty set creates no resource policy."
  type        = set(string)
  default     = []
}
