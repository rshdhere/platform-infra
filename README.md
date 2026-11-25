# Infrastructure

This repository is the shared home for infrastructure across my projects.

- `environments/` groups environment-specific configuration for development, staging, and production.
- `modules/` groups reusable infrastructure components for AWS, Kubernetes, and Helm.

Keep project-specific configuration separate within each environment. Put components used by multiple projects in the corresponding module directory.
