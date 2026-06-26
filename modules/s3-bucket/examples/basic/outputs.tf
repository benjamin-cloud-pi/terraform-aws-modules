output "bucket_name" {
  description = "Planned S3 bucket name from the example module call."
  value       = module.s3_bucket.bucket_name
}
