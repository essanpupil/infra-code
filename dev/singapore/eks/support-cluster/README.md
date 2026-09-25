# support-cluster
This cluster is use to deploy supporting services such as argo-cd, automation or light cicd self hosted runner, monitoring systems, etc.

This root creates a three-AZ private EKS cluster with:

- Two on-demand system nodes for support services.
- A scale-to-zero diversified Spot workload pool for cost-effective auxiliary workloads.
- One NAT gateway for development cost control.
- S3 remote state at `dev/singapore/eks/support-cluster/terraform.tfstate`.

Apply with `terraform init`, `terraform plan`, and `terraform apply`.
