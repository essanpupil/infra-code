module "terraform_state" {
  source      = "git::https://github.com/essanpupil/infra-code.git//modules/aws/s3-bucket"
  bucket_name = "platform-prod-terraform-state"

  tags = {
    Environment = "prod"
    ManagedBy   = "terraform"
    Purpose     = "terraform-state"
  }
}
