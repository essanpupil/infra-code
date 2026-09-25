variable "bucket_name" {
  description = "Globally unique S3 bucket name."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "bucket_name must be 3-63 characters, lowercase, and use only letters, numbers, dots, or hyphens."
  }
}

variable "kms_key_id" {
  description = "Optional customer-managed KMS key ID or ARN. AES256 is used when null."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Allow deletion of non-empty buckets. Keep false for Terraform state buckets."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to the bucket."
  type        = map(string)
  default     = {}
}
