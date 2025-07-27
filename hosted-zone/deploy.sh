#!/bin/bash

set -euo pipefail

echo "📦 Loading environment variables from .env"
set -a
source ../.env
set +a

echo "🚀 Initializing Terraform backend..."
terraform init -reconfigure \
  -backend-config="bucket=vitr-terraform-states" \
  -backend-config="key=users/${GITHUB_USER}/${PROJECT_NAME}/hosted-zone/terraform.tfstate" \
  -backend-config="region=${AWS_REGION}" \
  -backend-config="encrypt=true"

echo "📐 Applying Terraform configuration..."
terraform apply -auto-approve \
  -var="domain_name=${DOMAIN_NAME}" \

echo "📤 Extracting outputs..."
ZONE_ID=$(terraform output -raw zone_id)

echo "🔐 Storing Hosted Zone ID in SSM: /${PROJECT_NAME}/hosted_zone_id"
aws ssm put-parameter \
  --name "/${PROJECT_NAME}/hosted_zone_id" \
  --value "$ZONE_ID" \
  --type "String" \
  --overwrite \
  --region "${AWS_REGION}"

echo "✅ Deployment complete"
echo "   - Hosted Zone ID: $ZONE_ID"
