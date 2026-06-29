variable "project" {
  description = "Project identifier used as part of the S3 bucket naming convention"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9]{1,30}[a-z0-9]$", var.project))
    error_message = "project must be 3-32 characters, use lowercase letters, numbers or hyphens, and start end witch s letter or number"
  }
}

variable "environment" {
  description = "Environment identifier used as part of the S3 bucket naming convention."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,18}[a-z0-9]$", var.environment))
    error_message = "environment must be 3-20 characters, use lowercase letters, numbers or hyphens, and start and end with a letter or number."
  }
}


variable "name" {
  description = "Short bucket purpose name used as part of the S3 bucket naming convention."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,30}[a-z0-9]$", var.name))
    error_message = "name must be 3-32 characters, use lowercase letters, numbers or hyphens, and start and end with a letter or number."
  }
}

variable "tags" {
  description = "Additional tags to merge witch module metadata tags"
  type        = map(string)
  default     = {}
}

variable "force_destroy" {
  description = "Wheter to allow terraform to delete the bucket even if it contains objects. Defaults to false for safer deletion"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "wheter to enable S3 bucket versioning"
  type        = bool
  default     = true

}

variable "object_ownership" {
  description = "S3 object ownership setting."
  type        = string
  default     = "BucketOwnerEnforced"

  validation {
    condition = contains([
      "BucketOwnerEnforced",
      "BucketOwnerPreferred",
      "ObjectWriter"
    ], var.object_ownership)

    error_message = "object_ownership must be one of: BucketOwnerEnforced, BucketOwnerPreferred, ObjectWriter."
  }
}

variable "enable_secure_transport" {
  description = "Whether to enforce secure transport (HTTPS) for S3 bucket access. Defaults to true for security."
  type        = bool
  default     = true
}

variable "enable_lifecycle" {
  description = "Whether to enable S3 lifecycle configuration for cost optimization. Defaults to true."
  type        = bool
  default     = true
}

variable "lifecycle_transition_to_ia_days" {
  description = "Number of days to wait before transitioning objects to Infrequent Access storage class. Defaults to 30."
  type        = number
  default     = 30

  validation {
    condition     = var.lifecycle_transition_to_ia_days >= 1
    error_message = "lifecycle_transition_to_ia_days must be greater than or equal to 1."
  }
}

variable "lifecycle_transition_to_glacier_days" {
  description = "Number of days to wait before transitioning objects to Glacier storage class. Defaults to 90."
  type        = number
  default     = 90

  validation {
    condition     = var.lifecycle_transition_to_glacier_days >= 1
    error_message = "lifecycle_transition_to_glacier_days must be greater than or equal to 1."
  }
}

variable "lifecycle_expiration_days" {
  description = "Number of days to wait before expiring objects. Set to null to disable expiration. Defaults to null for safer retention."
  type        = number
  default     = null
  nullable    = true

  validation {
    condition     = var.lifecycle_expiration_days == null || var.lifecycle_expiration_days >= 1
    error_message = "lifecycle_expiration_days must be null or greater than or equal to 1."
  }
}

variable "kms_key_id" {
  description = "ARN o ID de clave KMS para utilizar en el cifrado predeterminado de S3, si es nulo, S3 utiliza la clave KMS administrada por AWS `aws/s3` "
  type        = string
  default     = null
}

variable "abor_incomplete_multipart_upload_days" {
  description = "numeros de dias tras el inicio para cancelar las cargas multiparte incompletas"
  type        = number
  default     = 7

  validation {
    condition     = var.abor_incomplete_multipart_upload_days >= 1 && var.abor_incomplete_multipart_upload_days <= 30
    error_message = "abort_incomplete_multipart_upload_days debe estar entre 1 y 30"
  }

}
