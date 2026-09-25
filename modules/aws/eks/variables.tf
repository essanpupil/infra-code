variable "name" {
  description = "EKS cluster name."
  type        = string
}

variable "subnet_ids" {
  description = "Subnets used by the EKS control plane and node groups."
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least two subnet IDs are required for a highly available EKS cluster."
  }
}

variable "kubernetes_version" {
  description = "Kubernetes version for the EKS control plane."
  type        = string
  default     = "1.31"
}

variable "endpoint_private_access" {
  description = "Enable private Kubernetes API endpoint access."
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public Kubernetes API endpoint access."
  type        = bool
  default     = false
}

variable "endpoint_public_access_cidrs" {
  description = "CIDR ranges allowed to reach the public Kubernetes API endpoint."
  type        = list(string)
  default     = []
}

variable "enabled_cluster_log_types" {
  description = "EKS control-plane log types to send to CloudWatch."
  type        = set(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "node_pools" {
  description = "Managed node pools. Use ON_DEMAND for critical/system workloads and SPOT for interruptible workloads."
  type = map(object({
    capacity_type  = string
    instance_types = list(string)
    ami_type       = optional(string, "AL2023_x86_64_STANDARD")
    disk_size      = optional(number, 50)
    min_size       = number
    desired_size   = number
    max_size       = number
    subnet_ids     = optional(list(string))
    labels         = optional(map(string), {})
    taints = optional(list(object({
      effect = string
      key    = string
      value  = optional(string)
    })), [])
    max_unavailable_percentage = optional(number, 33)
    tags                       = optional(map(string), {})
  }))

  validation {
    condition = alltrue([
      for pool in var.node_pools :
      contains(["ON_DEMAND", "SPOT"], pool.capacity_type)
    ])
    error_message = "Each node pool capacity_type must be ON_DEMAND or SPOT."
  }

  validation {
    condition = alltrue([
      for pool in var.node_pools :
      pool.min_size <= pool.desired_size && pool.desired_size <= pool.max_size
    ])
    error_message = "Each node pool must satisfy min_size <= desired_size <= max_size."
  }
}

variable "addons" {
  description = "EKS managed add-ons keyed by add-on name."
  type = map(object({
    addon_version               = optional(string)
    resolve_conflicts_on_create = optional(string, "OVERWRITE")
    resolve_conflicts_on_update = optional(string, "OVERWRITE")
    service_account_role_arn    = optional(string)
  }))
  default = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }
}

variable "tags" {
  description = "Tags applied to EKS resources."
  type        = map(string)
  default     = {}
}
