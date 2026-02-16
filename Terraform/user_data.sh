#!/bin/bash
set -e

# Setup 2GB swap
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' >> /etc/fstab

# Install Docker & AWS CLI
sudo apt update -y
sudo apt install -y docker.io awscli
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu


# Login to ECR using IAM Role credentials
aws ecr get-login-password --region us-east-1 \
| sudo docker login --username AWS --password-stdin ${ecr_url}

# Pull image from ECR
sudo docker pull ${docker_images}

# Run Strapi container
sudo docker run -d \
  --restart unless-stopped \
  -p 1337:1337 \
  --name strapi-app \
  ${docker_images}


