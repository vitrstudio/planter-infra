#!/bin/bash
set -e

# Update packages
dnf update -y

# Install Docker
dnf install -y docker

# Enable and start Docker
systemctl enable docker
systemctl start docker

# Allow ec2-user to use Docker without sudo
usermod -aG docker ec2-user

# OPTIONAL: Pull your backend Docker image (uncomment and adjust)
# docker pull <your-image-name>

# OPTIONAL: Run your backend container (uncomment and adjust)
# docker run -d -p 8080:8080 <your-image-name>
