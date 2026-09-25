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

## Task C: CI/CD
1. Authentication from github to targets aws account is configured using OIDC. All other authentication, such as to docker is also using OIDC whenever possible.
2. For service authentication that does not suppoprt OIDC, we configure CICD secrets inside github repo action secrets.
3. For application or oeprational secrets like database credentials, kubernetes secrets, etc, we can utilize aws secrets manager or hashicorp vault. if using aws secrets manager, we need to limit access to the secrets using resource iam policy and iam role policy.
4. To add extra team isolations, we configure `CODEOWNERS` file.

## Additional Documentation
1. Folder modules is ideally deployed to its own github repo, and create release to be used by terraform configs in workload.
