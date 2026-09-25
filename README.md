## Task A: Terraform
Terraform folder layout is configured like diagram below.
```shell
.
├── central
│   └── global
│       └── iam-user
├── dev
│   ├── global
│   └── singapore
├── stg
│   ├── global
│   └── singapore
└── prod
    ├── global
    └── singapore
```        

Point of Interest
1. central, dev, staging, and prod they have their own aws account. This is to create isolation and blast radius protection.
2. Central is used as organization and administrative account. All iam user is declare in this account.
3. Dev, stg, and prod are workload accounts. This account provide iam role for specific task and allow users from iam-user in central account to assume role.
4. To avoid terraform conflict, we configure terraform backend with unique `key` value taken from relative path.

## Task B: Kubernetes
1. Create dedicated eks cluster for support services deployment such as argo-cd, self hosted cicd runners, monitoring services, etc. We can name this cluster `support-cluster`.
2. Create application eks cluster, separate cluster deployment for each product if needed. This is to reduce damage in case we have miss configuration. In this example, we deploy `erp-cluster` and `pos-cluster`.
3. 