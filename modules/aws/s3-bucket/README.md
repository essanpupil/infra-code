# S3 bucket module

Creates a private S3 bucket with versioning, server-side encryption, enforced
bucket-owner object ownership, public-access blocking, and a policy that denies
insecure transport.

The bucket has `prevent_destroy = true` and `force_destroy = false` by default,
which is appropriate for Terraform state. Removing the module therefore
requires an intentional lifecycle change before Terraform can destroy the
bucket.

```hcl
module "terraform_state" {
  source = "git::https://github.com/essanpupil/infra-code.git//modules/aws/s3-bucket"

  bucket_name = "example-dev-terraform-state"
  tags = {
    Purpose = "terraform-state"
  }
}
```
