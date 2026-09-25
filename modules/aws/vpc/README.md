# VPC module

This module creates an AWS VPC with one public and one private subnet per
Availability Zone, an internet gateway, route tables, and optional NAT
gateways. It is suitable as the network layer for the EKS module.

```hcl
module "vpc" {
  source = "./modules/aws/vpc"

  name               = "platform-prod"
  vpc_cidr           = "10.0.0.0/16"
  availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]

  public_subnet_cidrs  = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  private_subnet_cidrs = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20"]

  # One NAT per AZ is more resilient; one shared NAT costs less.
  single_nat_gateway = false

  tags = {
    Environment = "prod"
    Project     = "platform"
  }
}

module "eks" {
  source = "./modules/aws/eks"

  name       = "platform-prod"
  subnet_ids = module.vpc.private_subnet_ids_list
}
```

## Cost and availability

- `single_nat_gateway = true` creates one shared NAT gateway and reduces
  hourly and data-processing costs, but makes outbound private-subnet traffic
  dependent on one Availability Zone.
- The default `single_nat_gateway = false` creates one NAT gateway per AZ.
  This avoids cross-AZ NAT traffic and preserves outbound connectivity if one
  AZ has an outage.
- Use at least two Availability Zones for production and provide CIDRs in the
  same order as `availability_zones`.
- Set `enable_nat_gateway = false` for isolated networks that do not need
  internet egress. Private subnets will not receive a default route.

Run `terraform init` and `terraform validate` from the root configuration that
consumes this module.
