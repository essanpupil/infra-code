# support-cluster
This cluster is use to deploy supporting services such as argo-cd, automation or light cicd self hosted runner, monitoring systems, etc.

This root creates a three-AZ private EKS cluster with:

- Two on-demand system nodes for support services.
- A scale-to-zero diversified Spot workload pool for cost-effective auxiliary workloads.
- One NAT gateway for development cost control.
- Argo CD installed from the official `argo-cd` Helm chart.
- ERP and POS clusters registered as Argo CD managed clusters.
- S3 remote state at `dev/singapore/eks/support-cluster/terraform.tfstate`.

Apply the application clusters first so their Argo CD service-account
credentials exist in remote state:

1. `dev/singapore/eks/erp-cluster`
2. `dev/singapore/eks/pos-cluster`
3. `dev/singapore/eks/support-cluster`

Then apply the declarative Argo CD applications:

```sh
kubectl apply -f kubernetes/supports/erp-application.yaml
kubectl apply -f kubernetes/supports/pos-application.yaml
```

The application-cluster service accounts are bound to `cluster-admin` because
Argo CD must manage cluster-scoped and namespaced resources. Protect the
Terraform state and Argo CD namespace because the cluster bearer tokens are
stored there as sensitive data.
