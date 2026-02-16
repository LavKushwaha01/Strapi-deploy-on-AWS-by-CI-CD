# CI/CD Pipeline for Strapi Deployment (Docker Hub + Terraform + AWS EC2)

Loom video: https://www.loom.com/share/7d6261e67d804bc2be26079474ad396b

## Overview

This project implements a complete CI/CD pipeline to automate the build and deployment of a Strapi application using:

- Docker for containerization

- Docker Hub as the container registry

- GitHub Actions for CI/CD automation

- Terraform for Infrastructure as Code (IaC)

- AWS EC2 as the compute platform

The pipeline ensures that on every push to the main branch, a new Docker image is built and pushed to Docker Hub. The deployment to AWS EC2 is handled via a manually triggered Terraform workflow. A separate destroy workflow is provided to safely tear down all infrastructure.

 Architecture
Developer Push (GitHub)
        |
        v
GitHub Actions (CI)
  - Build Docker image
  - Push image to Docker Hub
        |
        v
GitHub Actions (CD - Manual)
  - Terraform Plan & Apply
  - Provision EC2
  - Pull Docker image
  - Run Strapi container
        |
        v
AWS EC2 (Public IP)
  - Strapi accessible on port 1337

## Repository Structure
```bash
├── Docker/
│   ├── Dockerfile
│   └── .dockerignore
├── Strapi/                     # Application source code
├── terraform/
│   ├── main.tf                 # EC2, SG, user_data
│   ├── variables.tf            # Input variables
│   ├── providers.tf            # AWS provider config
│   └── outputs.tf              # EC2 public IP
├── .github/
│   └── workflows/
│       ├── ci.yml              # CI: Build & push Docker image
│       ├── cd.yml              # CD: Terraform deploy
│       └── destroy.yml         # Destroy: Terraform destroy
└── README.md
```

## Required GitHub Secrets

Add the following secrets to your GitHub repository:

Docker Hub
DOCKERHUB_USERNAME = <your_dockerhub_username>
DOCKERHUB_TOKEN    = <dockerhub_access_token>
DOCKERHUB_REPO     = <your_dockerhub_username>/strapi-app

AWS
AWS_ACCESS_KEY_ID     = <your_aws_access_key>
AWS_SECRET_ACCESS_KEY = <your_aws_secret_key>
AWS_REGION            = us-east-1

---

## CI Workflow (Build & Push Image)

- Trigger: On every push to main
Actions:

- Build Docker image using Dockerfile

- Tag image with commit SHA

- Push image to Docker Hub

- This ensures each build is immutable and traceable to a Git commit.

## CD Workflow (Terraform Deploy)

- Trigger: Manual (workflow_dispatch)
Actions:

- Terraform init & validate

- Terraform plan with Docker Hub repo + image tag

- Terraform apply to:

- Create EC2 instance

- Install Docker

- Pull Docker image from Docker Hub

- Run Strapi container on port 1337

- After successful deployment, access the app at:

- http://<EC2_PUBLIC_IP>:1337

---

## Destroy Workflow (Terraform Destroy)

A separate workflow is provided to safely tear down all infrastructure.

- Trigger: Manual
Confirmation: Requires typing DESTROY to prevent accidental deletion.

- This workflow runs:

- terraform destroy -auto-approve


- to remove all Terraform-managed AWS resources.


## Test locally on EC2
- curl http://localhost:1337