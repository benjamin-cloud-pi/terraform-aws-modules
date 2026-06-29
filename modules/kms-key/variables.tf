variable "project" {
  description = "Project identifier used as part of the KMS key naming convention"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,30}[a-z0-9]$", var.project))
    error_message = "project must be 3-32 characters, use lowercase letters, numbers or hyphens, and start and end with a letter or number."
  }
}

variable "environment" {
  description = "Environment identifier used as part of the KMS key naming convention."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,18}[a-z0-9]$", var.environment))
    error_message = "environment must be 3-20 characters, use lowercase letters, numbers or hyphens, and start and end with a letter or number."
  }
}

variable "name" {
  description = "Short key purpose name used as part of the KMS key naming convention."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,30}[a-z0-9]$", var.name))
    error_message = "name must be 3-32 characters, use lowercase letters, numbers or hyphens, and start and end with a letter or number."
  }
}

variable "description" {
  description = "Description of the KMS key for auditing and documentation purposes."
  type        = string
  default     = "Managed by Terraform"
}

variable "enable_key_rotation" {
  description = "Whether to enable automatic key rotation for the KMS key. Defaults to true for security."
  type        = bool
  default     = true
}

variable "deletion_window_in_days" {
  description = "The waiting period in days before KMS key deletion. Must be between 7 and 30 days. Defaults to 30."
  type        = number
  default     = 30

  validation {
    condition     = var.deletion_window_in_days >= 7 && var.deletion_window_in_days <= 30
    error_message = "deletion_window_in_days must be between 7 and 30 days."
  }
}

variable "tags" {
  description = "Additional tags to merge with module metadata tags"
  type        = map(string)
  default     = {}
}
