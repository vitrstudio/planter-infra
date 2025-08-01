#!/usr/bin/env bash
set -euo pipefail

echo "📦 Loading environment variables from .env"
set -a
source ../.env
set +a

echo "🚀 Initializing Terraform backend..."
terraform init -reconfigure \
  -backend-config="bucket=vitr-terraform-states" \
  -backend-config="key=users/${GITHUB_USER}/${PROJECT_NAME}/infra/terraform.tfstate" \
  -backend-config="region=${AWS_REGION}" \
  -backend-config="encrypt=true"

echo
echo "⚠️  WARNING: This will destroy ALL Terraform-managed resources in your project!"
read -p "Are you sure you want to continue? (yes/no): " CONFIRM
if [[ "$CONFIRM" != "yes" ]]; then
  echo "❌  Aborted."
  exit 1
fi

echo
echo "🔥  Destroying all resources…"
terraform destroy -auto-approve \
  -var="project_name=${PROJECT_NAME}" \
  -var="project_id=${PROJECT_ID}" \
  -var="domain_name=${DOMAIN_NAME}" \
  -var="region=${AWS_REGION}" \
  -var="certificate_arn=${CERTIFICATE_ARN}" \
  -var="hosted_zone_id=${HOSTED_ZONE_ID}" \
  -var="ami_id=${AMI_ID}" \
  -var="db_name=${DB_NAME}" \
  -var="db_user=${DB_USERNAME}" \
  -var="db_password=${DB_PASSWORD}"

echo
echo "🧹 Cleaning up SSM parameters…"

# List of SSM parameters to delete
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
