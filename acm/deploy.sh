#!/bin/bash

set -euo pipefail

echo "📦 Loading environment variables from .env"
set -a
source ../.env
set +a

echo "🔍 Fetching Hosted Zone ID from SSM..."
HOSTED_ZONE_ID=$(aws ssm get-parameter \
  --name "/${PROJECT_NAME}/hosted_zone_id" \
  --region "${AWS_REGION}" \
  --query "Parameter.Value" \
  --output text)

echo "🌐 Hosted Zone ID: $HOSTED_ZONE_ID"

echo "🚀 Initializing Terraform backend..."
terraform init -reconfigure \
  -backend-config="bucket=vitr-terraform-states" \
  -backend-config="key=users/${GITHUB_USER}/${PROJECT_NAME}/acm/terraform.tfstate" \
  -backend-config="region=${AWS_REGION}" \
  -backend-config="encrypt=true"

echo "📐 Applying Terraform configuration..."
terraform apply -auto-approve \
  -var="domain_name=${DOMAIN_NAME}" \
  -var="region=${AWS_REGION}" \
  -var="hosted_zone_id=${HOSTED_ZONE_ID}"

echo "📤 Extracting outputs..."
CERT_ARN=$(terraform output -raw certificate_arn)

echo "🔐 Storing Certificate ARN in SSM: /${PROJECT_NAME}/certificate_arn"
aws ssm put-parameter \
  --name "/${PROJECT_NAME}/certificate_arn" \
  --value "$CERT_ARN" \
  --type "String" \
  --overwrite \
  --region "${AWS_REGION}"

echo "✅ Deployment complete"
echo "   - Certificate ARN: $CERT_ARN"
