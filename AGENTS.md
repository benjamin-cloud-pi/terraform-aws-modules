# AGENTS.md

## Project overview

This repository contains reusable Terraform modules for AWS.

The goal is to build a curated internal module library using Terraform, consumed by Terragrunt from a separate live infrastructure repository.

The modules must follow AWS Well-Architected principles from the beginning:
- Operational Excellence
- Security
- Reliability
- Performance Efficiency
- Cost Optimization
- Sustainability

This repository is not intended to generate all modules at once. Work must be incremental, reviewed, and module-by-module.

## Main objective

Create reusable, secure-by-default, well-documented Terraform modules for AWS.

Each module should be:
- Small and focused.
- Opinionated but configurable.
- Secure by default.
- Easy to consume with Terragrunt.
- Documented with examples.
- Aligned with Well-Architected best practices.
- Suitable for multi-account and multi-environment AWS usage.

## Important working rule

Do not generate the full repository or all modules in one task.

Always work incrementally.

When asked to create or modify something:
1. Inspect the existing structure first.
2. Propose a small plan.
3. Modify only the requested module or document.
4. Avoid broad refactors unless explicitly requested.
5. Prefer minimal, reviewable changes.

## Repository layout

Expected high-level structure:

```text
terraform-aws-modules/
├── README.md
├── MODULE_STANDARD.md
├── WELL_ARCHITECTED_CHECKLIST.md
├── AGENTS.md
├── modules/
│   ├── s3-bucket/
│   ├── kms-key/
│   ├── iam-role/
│   ├── security-group/
│   ├── vpc/
│   ├── cloudwatch-log-group/
│   ├── rds/
│   ├── lambda/
│   ├── alb/
│   └── waf/
└── docs/
