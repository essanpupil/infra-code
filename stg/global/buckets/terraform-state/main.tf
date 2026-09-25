module "terraform_state" {
  source      = "git::https://github.com/essanpupil/infra-code.git//modules/aws/s3-bucket"
  bucket_name = "platform-stg-terraform-state"

  tags = {
    Environment = "stg"
    ManagedBy   = "terraform"
    Purpose     = "terraform-state"
  }
}
