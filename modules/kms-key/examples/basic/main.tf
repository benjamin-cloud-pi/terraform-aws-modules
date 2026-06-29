module "kms_key" {
  source = "../../"

  project     = "example"
  environment = "dev"
  name        = "secrets"

  tags = {
    Owner      = "platform"
    CostCenter = "shared"
  }

  # Security settings
  enable_key_rotation     = true
  deletion_window_in_days = 30

  description = "KMS key for encryption at rest"
}
