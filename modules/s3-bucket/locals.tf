locals {
  bucket_name = "${var.project}-${var.environment}-${var.name}"

  common_tags = merge(
    {
      Project     = var.project
      Environment = var.environment
      Name        = local.bucket_name
      ManagedBy   = "terraform"
      Module      = "s3-bucket"
    },
    var.tags
  )
}
