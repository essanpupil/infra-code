# Development Terraform state bucket

Creates `platform-dev-terraform-state` in Singapore
(`ap-southeast-1`) using the shared S3 bucket module.

The bucket is configured with:

- Versioning for state recovery
- Server-side encryption using S3-managed keys
- Blocked public access
- Bucket-owner-enforced object ownership
- A policy denying non-TLS requests
- `prevent_destroy = true`

Apply this bootstrap configuration before configuring other Terraform roots to
use the bucket as their remote backend. The backend block cannot reference
module outputs, so update each consuming root's backend configuration with the
bucket name after this bucket exists.

```sh
terraform init
terraform plan
terraform apply
```
