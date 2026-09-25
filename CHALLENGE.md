# DevOps Pre-Interview Test
Assume: AWS, Kubernetes, GitHub, CI/CD tool you know, 3 envs (dev/staging/prod).
Cost matters, prod reliability matters most.

## Task A — Terraform
Explain how you handle:
- Multi-environment setup (layout + env differences).
- Working with a team (how you avoid conflicts and keep changes safe).

## Task B — Kubernetes
Explain how you achieve:
- HA/reliability for workloads (deploy patterns + scaling).
- Cost effectiveness (cluster/node strategy and non-prod vs prod tradeoffs).

## Task C — CI/CD Secrets
Explain:
- Where secrets live and how they get to Kubernetes safely.
- How you handle the secrets access to team.

## Deliverables
- A single written document answering Tasks A–C.
- Include example files where relevant:
  - Terraform files & folder layout
  - Kubernetes YAML manifest
  - CI/CD scripts (GitHub Actions, Jenkins, GitLab CI, etc.)
- Package your submission as a .zip file containing:
  - One Markdown (.md) file with your answers for Tasks A–C.
  - Any example files you reference.
- Keep it concise but specific, focusing on real-world approach and tradeoffs.
