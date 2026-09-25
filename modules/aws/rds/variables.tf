variable "identifier" {
  description = "Unique RDS instance identifier."
  type        = string
}

variable "vpc_id" {
  description = "VPC containing the database."
  type        = string
}

variable "subnet_ids" {
  description = "At least two data subnet IDs in different Availability Zones."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least two subnet IDs are required for an RDS subnet group."
  }
}

variable "engine" {
  description = "RDS database engine."
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Optional RDS engine version."
  type        = string
  default     = null
}

variable "instance_class" {
  description = "RDS instance class."
  type        = string
  default     = "db.t4g.micro"
}

variable "allocated_storage" {
  description = "Initial storage size in GiB."
  type        = number
  default     = 20
}

variable "max_allocated_storage" {
  description = "Maximum storage size for autoscaling in GiB. Set to 0 to disable."
  type        = number
  default     = 100
}

variable "storage_type" {
  description = "RDS storage type."
  type        = string
  default     = "gp3"
}

variable "db_name" {
  description = "Initial database name."
  type        = string
  default     = "app"
}

variable "username" {
  description = "Master database username."
  type        = string
  default     = "appuser"
}

variable "port" {
  description = "Database port."
  type        = number
  default     = 5432
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to connect to the database."
  type        = set(string)
  default     = []
}

variable "allowed_security_group_ids" {
  description = "Security groups allowed to connect to the database."
  type        = set(string)
  default     = []
}

variable "multi_az" {
  description = "Deploy a synchronous standby in another Availability Zone."
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Backup retention in days."
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Daily backup window."
  type        = string
  default     = "18:00-19:00"
}

variable "maintenance_window" {
  description = "Weekly maintenance window."
  type        = string
  default     = "sun:19:00-sun:20:00"
}

variable "kms_key_id" {
  description = "Optional customer-managed KMS key for storage encryption."
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "Prevent accidental database deletion."
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip the final snapshot on destroy. Keep true only for disposable development databases."
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Apply modifications immediately."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to RDS resources."
  type        = map(string)
  default     = {}
}
