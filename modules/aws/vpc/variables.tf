variable "name" {
  description = "Name prefix for VPC resources."
  type        = string
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "Availability Zones used by the public and private subnets."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "At least two Availability Zones are required."
  }
}

variable "public_subnet_cidrs" {
  description = "One public subnet CIDR per Availability Zone."
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == length(var.availability_zones)
    error_message = "public_subnet_cidrs must contain one CIDR per Availability Zone."
  }
}

variable "private_subnet_cidrs" {
  description = "One private subnet CIDR per Availability Zone."
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) == length(var.availability_zones)
    error_message = "private_subnet_cidrs must contain one CIDR per Availability Zone."
  }
}

variable "data_subnet_cidrs" {
  description = "Optional data subnet CIDRs, one per Availability Zone. Data subnets have no default internet route."
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.data_subnet_cidrs) == 0 || length(var.data_subnet_cidrs) == length(var.availability_zones)
    error_message = "data_subnet_cidrs must be empty or contain one CIDR per Availability Zone."
  }
}

variable "enable_nat_gateway" {
  description = "Create NAT gateways and private-subnet default routes."
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use one shared NAT gateway for all private subnets. Lower cost, lower availability."
  type        = bool
  default     = false
}

variable "assign_generated_ipv6_cidr_block" {
  description = "Assign an AWS-generated IPv6 CIDR block to the VPC."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to VPC resources."
  type        = map(string)
  default     = {}
}
