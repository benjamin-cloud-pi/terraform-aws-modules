locals {
  key_alias = "${var.project}-${var.environment}-${var.name}"

  common_tags = merge(
    {
      Project     = var.project
      Environment = var.environment
      Name        = local.key_alias
      ManagedBy   = "terraform"
      Module      = "kms-key"
    },
    var.tags
  )
}
