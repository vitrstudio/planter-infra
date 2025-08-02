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

echo "🔍 Fetching Certificate ARN from SSM..."
CERTIFICATE_ARN=$(aws ssm get-parameter \
  --name "/${PROJECT_NAME}/certificate_arn" \
  --region "${AWS_REGION}" \
  --query "Parameter.Value" \
  --output text)

echo "🌐 Hosted Zone ID:      $HOSTED_ZONE_ID"
echo "🔒 Certificate ARN:    $CERTIFICATE_ARN"

echo "🚀 Re-initializing Terraform backend"
terraform init -reconfigure -migrate-state \
  -backend-config="bucket=vitr-terraform-states" \
  -backend-config="key=users/${GITHUB_USER}/${PROJECT_NAME}/infra/terraform.tfstate" \
  -backend-config="region=${AWS_REGION}" \
  -backend-config="encrypt=true"

echo "⚠️  WARNING: This will destroy ALL Terraform-managed resources in your project!"
read -p "Are you sure you want to continue? (yes/no): " CONFIRM
if [[ "$CONFIRM" != "yes" ]]; then
  echo "❌ Aborted."
  exit 1
fi

echo "🔥 Destroying Terraform-managed infrastructure…"
terraform destroy -auto-approve \
  -var "region=${AWS_DEFAULT_REGION}" \
  -var "project_id=${PROJECT_ID}" \
  -var "project_name=${PROJECT_NAME}" \
  -var "domain_name=${DOMAIN_NAME}" \
  -var "ami_id=${AMI_ID}" \
  -var "db_name=${DB_NAME}" \
  -var "db_user=${DB_USERNAME}" \
  -var "db_password=${DB_PASSWORD}" \
  -var "hosted_zone_id=${HOSTED_ZONE_ID}" \
  -var "certificate_arn=${CERTIFICATE_ARN}"

echo "🧹 Cleaning up SSM parameters…"

PARAMS=(
  "/${PROJECT_NAME}/db_password"
  "/${PROJECT_NAME}/deployment_bucket"
  "/${PROJECT_NAME}/ec2_instance_id"
  "/${PROJECT_NAME}/ec2_public_ip"
  "/${PROJECT_NAME}/github_role_arn"
  "/${PROJECT_NAME}/rds_endpoint"
)

for PARAM in "${PARAMS[@]}"; do
  echo "→ Deleting SSM parameter: ${PARAM}"
  aws ssm delete-parameter \
    --name "${PARAM}" \
    --region "${AWS_REGION}" \
  && echo "   ✅ Deleted ${PARAM}" \
  || echo "   ⚠️  Parameter not found or could not delete: ${PARAM}"
done

echo "✅ Destruction complete"
