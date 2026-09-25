# pos-cluster
Dedicated cluster where we deploy applications, and applications only. We do not deploy supporting systems such as monitoring, cicd runner, etc. All application in this cluster is owned by POS team.

This root creates a three-AZ private EKS cluster with:

- Three on-demand system nodes for availability and critical add-ons.
- A diversified Spot workload pool for cost-effective interruptible POS workloads.
- One NAT gateway for development cost control.
- S3 remote state at `dev/singapore/eks/pos-cluster/terraform.tfstate`.

Apply with `terraform init`, `terraform plan`, and `terraform apply`.
