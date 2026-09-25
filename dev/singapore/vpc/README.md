# Shared development VPC

Creates the single shared three-AZ VPC used by the ERP, POS, and support EKS
clusters in Singapore.

The VPC provides public, private, and isolated data subnets. A single NAT
gateway is used to reduce development cost; production should use one NAT
gateway per Availability Zone.

Apply this root before applying any EKS cluster root:

```sh
terraform init
terraform plan
terraform apply
```

Its state is stored at `dev/singapore/vpc/terraform.tfstate`. The EKS roots
read its outputs through the S3 `terraform_remote_state` data source.
