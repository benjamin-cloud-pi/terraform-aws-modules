output "key_id" {
  description = "The globally unique identifier for the KMS key"
  value       = module.kms_key.key_id
}

output "key_arn" {
  description = "The Amazon Resource Name (ARN) of the KMS key"
  value       = module.kms_key.key_arn
}

output "alias_name" {
  description = "The alias of the KMS key"
  value       = module.kms_key.alias_name
}

output "common_tags" {
  description = "The common tags applied to the KMS key"
  value       = module.kms_key.common_tags
}
