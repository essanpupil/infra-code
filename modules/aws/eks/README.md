# EKS module

This module deploys an Amazon EKS control plane, its IAM roles, managed
add-ons, an IAM OIDC provider for IRSA, and configurable EKS managed node
groups. The VPC, subnets, NAT gateways, and security groups are intentionally
owned by the consuming configuration.

The module requires at least two subnets. Pass private subnets from at least
two Availability Zones to keep the control plane highly available. The
Kubernetes API is private by default; if public access is enabled, restrict
`endpoint_public_access_cidrs` to trusted networks.

The AWS VPC CNI add-on enables prefix delegation by default
(`ENABLE_PREFIX_DELEGATION=true`) to increase pod density per node. Set
`enable_prefix_delegation = false` to disable the default, or provide explicit
`configuration_values` for the `vpc-cni` entry in `addons` when custom CNI
configuration is required.

Karpenter AWS integration is enabled by default. The module creates the
controller IRSA role, node instance role support, interruption SQS queue, and
EventBridge interruption rules. Use the `karpenter_controller_role_arn`,
`karpenter_node_role_name`, and `karpenter_interruption_queue_name` outputs
when installing the Karpenter controller and defining its `EC2NodeClass`.
Set `enable_karpenter = false` only when Karpenter is not used.

## Example

```hcl
module "eks" {
  source = "./modules/aws/eks"

  name       = "platform-prod"
  subnet_ids = module.vpc.private_subnet_ids

  tags = {
    Environment = "prod"
    Project     = "platform"
  }

  node_pools = {
    system = {
      capacity_type              = "ON_DEMAND"
      instance_types             = ["m7i.large"]
      min_size                   = 3
      desired_size               = 3
      max_size                   = 6
      max_unavailable_percentage = 33
      labels                     = { "node-role.kubernetes.io/system" = "true" }
      taints = [{
        key    = "workload"
        value  = "system"
        effect = "NO_SCHEDULE"
      }]
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
}
```

## Cost and availability guidance

- Keep a multi-node `ON_DEMAND` system pool with `min_size >= 2` (normally 3
  for production) for cluster add-ons and critical workloads.
- Use multiple instance types in `SPOT` pools to improve capacity
  diversification. Keep `min_size = 0` only for workloads that tolerate
  interruption.
- Put each pool across the same private subnets so managed node groups can
  spread capacity across Availability Zones.
- Keep each on-demand pool's minimum and desired size at least the number of
  supplied Availability Zones. This gives every AZ baseline capacity; Spot
  pools may still scale to zero.
- Use labels and taints to keep critical workloads off Spot pools. Kubernetes
  workloads must provide matching tolerations for tainted pools.
- Set `max_unavailable_percentage` to balance safe rolling upgrades against
  upgrade speed.

Run `terraform init` and `terraform validate` from the root configuration that
consumes this module.
