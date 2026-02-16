
resource "aws_instance" "first_ec2_from_terraform" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = var.instance_type
  key_name               = aws_key_pair.create_key.key_name
  vpc_security_group_ids = [aws_security_group.security_group.id]

  iam_instance_profile = "ec2-ecr-role"

root_block_device {
    volume_size = 20   # GB (safe within Free Tier)
    volume_type = "gp3"
  }
 user_data = <<-EOF
  #!/bin/bash
  set -e

  # Setup swap (optional but useful for low RAM EC2)
  fallocate -l 2G /swapfile || true
  chmod 600 /swapfile
  mkswap /swapfile || true
  swapon /swapfile || true
  echo '/swapfile none swap sw 0 0' >> /etc/fstab

  # Install Docker & AWS CLI
  apt update -y
  apt install -y docker.io awscli
  systemctl start docker
  systemctl enable docker

  # Login to ECR using IAM Role
  aws ecr get-login-password --region us-east-1 \
  | docker login --username AWS --password-stdin ${var.ecr_repo}

  # Pull latest image
  docker pull ${var.ecr_repo}:${var.image_tag}

  # Stop old container if exists
  docker rm -f strapi-app || true

  # Run Strapi container
  docker run -d \
    --restart unless-stopped \
    -p 1337:1337 \
    --name strapi-app \
    ${var.ecr_repo}:${var.image_tag}
EOF


    tags = {
    Name = "Strapi-Terraform-EC2"
  }
}
