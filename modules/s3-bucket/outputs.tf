output "bucket_id" {
  description = "The ID of the S3 bucket"
  value       = aws_s3_bucket.this.id
}

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.this.bucket
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.this.arn
}

output "bucket_domain_name" {
  description = "The bucket domain name of the S3 bucket"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "The bucket regional domain name of the S3 bucket"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}

output "common_tags" {
  description = "The common tags applied to the S3 bucket"
  value       = local.common_tags
}

output "bucket_policy" {
  description = "The bucket policy applied to the S3 bucket"
  value       = try(aws_s3_bucket_policy.this[0].policy, "")
}

output "lifecycle_configuration" {
  description = "The lifecycle configuration applied to the S3 bucket"
  value       = try(aws_s3_bucket_lifecycle_configuration.this[0], null)
}
