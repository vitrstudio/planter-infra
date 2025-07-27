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

echo "⚠️ WARNING: This will destroy the ACM infrastructure"
read -p "Are you sure you want to continue? (yes/no): " CONFIRM
if [[ "$CONFIRM" != "yes" ]]; then
  echo "❌ Aborted."
  exit 1
fi

echo "🔥 Destroying Terraform-managed infrastructure..."
terraform destroy -auto-approve \
  -var="domain_name=${DOMAIN_NAME}" \
  -var="region=${AWS_REGION}" \
  -var="hosted_zone_id=${HOSTED_ZONE_ID}"

echo "🧹 Cleaning up SSM parameters..."
aws ssm delete-parameter \
  --name "/${PROJECT_NAME}/certificate_arn" \
  --region "${AWS_REGION}" || echo "⚠️ Parameter not found: certificate_arn"

echo "✅ Destruction complete"
