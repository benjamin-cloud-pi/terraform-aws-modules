output "key_id" {
  description = "The globally unique identifier for the KMS key"
  value       = aws_kms_key.this.key_id
}

output "key_arn" {
  description = "The Amazon Resource Name (ARN) of the KMS key"
  value       = aws_kms_key.this.arn
}

output "alias_name" {
  description = "The alias of the KMS key"
  value       = aws_kms_alias.this.name
}

output "common_tags" {
  description = "The common tags applied to the KMS key"
  value       = local.common_tags
}
