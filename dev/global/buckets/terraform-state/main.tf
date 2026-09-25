module "terraform_state" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/aws/s3-bucket"

  bucket_name = "platform-dev-terraform-state"

  tags = {
    Environment = "dev"
    ManagedBy   = "terraform"
    Purpose     = "terraform-state"
  }
}
