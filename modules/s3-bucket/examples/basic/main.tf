module "s3_bucket" {
  source = "../../"

  project     = "example"
  environment = "dev"
  name        = "artifacts"

  tags = {
    Owner      = "platform"
    CostCenter = "shared"
  }

  # Security settings
  enable_secure_transport = true

  # Lifecycle settings for cost optimization
  enable_lifecycle                     = true
  lifecycle_transition_to_ia_days      = 30
  lifecycle_transition_to_glacier_days = 90
  lifecycle_expiration_days            = 365
}
