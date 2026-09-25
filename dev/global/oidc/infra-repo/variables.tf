variable "aws_region" {
  description = "AWS region for this global IAM configuration."
  type        = string
  default     = "ap-southeast-1"
}

variable "managed_policy_arns" {
  description = "Managed policy ARNs attached to the GitHub Actions role."
  type        = set(string)
  default     = []
}
