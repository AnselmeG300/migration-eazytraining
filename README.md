# AWS Infrastructure Migration & Refactoring — EAZYTraining

[![Terraform](https://img.shields.io/badge/IaC-Terraform-7B42BC?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazonaws)](https://aws.amazon.com/)
[![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?logo=githubactions)](https://github.com/features/actions)
[![Terraform Cloud](https://img.shields.io/badge/State-Terraform%20Cloud-7B42BC?logo=terraform)](https://app.terraform.io/)

## Overview

Complete overhaul and migration of the **EAZYLabs** and **EAZYTraining** platforms to the `eu-west-1` (Ireland) AWS region. This project transitions a historically manual infrastructure into a fully code-driven environment using Infrastructure as Code (IaC), while applying FinOps practices to significantly reduce cloud costs.

**Live applications:**
- [https://eazytraining.fr](https://eazytraining.fr)
- [https://docker.labs.eazytraining.fr](https://docker.labs.eazytraining.fr)

---

## Context

Both platforms were previously deployed manually in the `eu-west-3` (Paris) region. This project introduces:

- Full infrastructure reconstruction and region migration
- Containerization of workloads
- Introduction of IaC on environments with no prior automation
- A FinOps audit and cost optimization strategy

---

## Architecture

| Resource | Description |
|---|---|
| **EC2** | WordPress application server (t2.large, CentOS) with IAM instance profile |
| **EBS** | Persistent storage volume attached to the EC2 instance (100 GB, gp2) |
| **EIP** | Static Elastic IP associated to the EC2 instance |
| **RDS** | MySQL 5.7 managed database instance (db.t2.micro, up to 100 GB auto-scaling) |
| **CloudFront** | CDN distribution in front of the application |
| **Security Groups** | Granular rules for EC2, RDS, SSH and EBS |
| **IAM Role** | EC2 instance role with SSM and CloudWatch agent policies |
| **Provisioners** | Remote deployment via SSH: Docker install, EBS mount, app bootstrap |

### Infrastructure Diagram

![INFRA EAZYTraining](INFRA%20EAZYTraining.png)

### Other Applications

![OTHER APPs EAZYTraining](OTHER%20APPs%20EAZYTraining.png)

---

## Repository Structure

```
.
├── main.tf           # EBS attachment and EIP association
├── provider.tf       # AWS provider configuration
├── ec2.tf            # EC2 instance resource
├── ebs.tf            # EBS volume resource
├── eip.tf            # Elastic IP resource
├── rds.tf            # RDS MySQL instance
├── cloudfront.tf     # CloudFront distribution (imported)
├── sg.tf             # Security groups and rules
├── role.tf           # IAM role, instance profile and policy attachments
├── provisioners.tf   # File transfer and remote-exec provisioners (Docker, app setup)
├── data.tf           # Data sources
├── imports.tf        # Terraform import blocks
├── output.tf         # Outputs (Elastic IP)
└── variables.tf      # All input variables
```

---

## Key Variables

| Variable | Default | Description |
|---|---|---|
| `instance_type` | `t2.large` | EC2 instance type |
| `rds_instance_type` | `db.t2.micro` | RDS instance type |
| `size` | `100` | EBS volume size (GB) |
| `ssh_key` | `eazytraining-migration` | EC2 key pair name |
| `maintainer` | `eazytraining` | Tag applied to resources |
| `min_size` / `max_size` | `0` / `1` | ASG capacity bounds |

---

## IaC & CI/CD Stack

- **Terraform** — Infrastructure provisioning
- **Terraform Cloud** — Remote state management and plan/apply pipeline
- **GitHub Actions** — Automated deployment workflow
- **Dependabot** — Automated dependency updates (`.github/dependabot.yml`)

---

## FinOps & Optimizations

- **~50% monthly cost reduction**: $950 → $450/month
- Eliminated **400+ GB × 21 months** of unnecessary weekly snapshots
- Introduced a targeted backup policy for EAZYTraining only:
  - Database + configuration files only
  - Maximum 2-day retention
- Stopped non-critical applications when idle (e.g. monthly payroll service)
- Consolidated all services into a **single VPC**
- Migrated from Paris (`eu-west-3`) to Ireland (`eu-west-1`): cheaper services + GDPR compliant
- Deployed **Compute Savings Plans** covering EC2, Fargate and Lambda

---

## Deployment

> Requires Terraform CLI, AWS credentials and the SSH key `eazytraining-migration.pem` placed under `./scripts/`.

```bash
# Initialize
terraform init

# Preview changes
terraform plan

# Apply
terraform apply
```

State is managed remotely via **Terraform Cloud**.

---

## Results

| Metric | Before | After |
|---|---|---|
| Monthly cost | ~$950 | ~$450 |
| Snapshot storage | 400 GB + 60 GB (21 months) | Eliminated |
| Infrastructure management | Manual | 100% IaC |
| Region | eu-west-3 (Paris) | eu-west-1 (Ireland) |
| Architecture alignment | — | AWS Well-Architected — Cost Optimization pillar |

---

## Team

Led by a team of 3 engineers with full hands-on implementation, including technical lead responsibilities covering architecture decisions, IaC implementation and FinOps audit.
