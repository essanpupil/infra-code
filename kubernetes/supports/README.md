# Argo CD applications

These declarative Argo CD `Application` resources deploy the ERP and POS Helm
charts from the `main` branch:

- `erp-application.yaml` deploys `kubernetes/erp` into the `erp` namespace.
- `pos-application.yaml` deploys `kubernetes/pos` into the `pos` namespace.

Apply them after Argo CD is installed:

```sh
kubectl apply -f kubernetes/supports/erp-application.yaml
kubectl apply -f kubernetes/supports/pos-application.yaml
```

Both applications use automated sync, pruning, and self-healing. The
`CreateNamespace=true` option allows Argo CD to create the target namespaces.
