# EKS module

This module deploys an Amazon EKS cluster with:

- A highly available control plane across the supplied subnets.
- Private API endpoint access by default.
- EKS managed core add-ons.
- EKS managed node groups with independent scaling, instance types, labels, taints, and capacity type.
- A default on-demand `system` pool and a scale-to-zero Spot `spot` pool to reduce compute cost.
- An IAM OIDC provider for IAM Roles for Service Accounts (IRSA).

The module expects the VPC and subnets to already exist. Use private subnets in at least two Availability Zones. NAT gateways, their routing, and security-group rules are intentionally outside this module.

## Example

```hcl
module "eks" {
  source = "./modules/aws/eks"

  name               = "platform-prod"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  tags = {
    Environment = "prod"
    Project     = "platform"
  }
}
```

The default pools keep two on-demand nodes for cluster/system workloads and use Spot capacity for burstable workloads. For production workloads, override `node_pools` and use taints/tolerations to prevent critical workloads from landing on Spot nodes.

```hcl
node_pools = {
  system = {
    capacity_type  = "ON_DEMAND"
    instance_types = ["m7i.large"]
    min_size       = 3
    desired_size   = 3
    max_size       = 6
    labels         = { "node-role.kubernetes.io/system" = "true" }
  }

  workloads = {
    capacity_type  = "SPOT"
    instance_types = ["m7i.large", "m6i.large", "m5.large"]
    min_size       = 0
    desired_size   = 2
    max_size       = 20
    labels         = { workload = "general" }
  }
}
```

Run `terraform init` and `terraform validate` from the root configuration that consumes this module.
