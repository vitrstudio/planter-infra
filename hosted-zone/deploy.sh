#!/bin/bash

set -euo pipefail
set -a
source ../.env
set +a

terraform init \
  -backend-config="bucket=codefarm-terraform-states" \
  -backend-config="key=users/${GITHUB_USER}/${PROJECT_NAME}/terraform.tfstate" \
  -backend-config="region=${AWS_REGION}" \
  -backend-config="encrypt=true"

terraform apply -auto-approve \
  -target=aws_route53_zone.primary \
  -var="domain_name=${DOMAIN_NAME}"

HOSTED_ZONE_ID=$(terraform output -raw zone_id)

aws secretsmanager create-secret \
  --name "${PROJECT_NAME}/hosted_zone_id" \
  --secret-string "$HOSTED_ZONE_ID" \
  --region "${AWS_REGION}" || \
aws secretsmanager put-secret-value \
  --secret-id "${PROJECT_NAME}/hosted_zone_id" \
  --secret-string "$HOSTED_ZONE_ID" \
  --region "${AWS_REGION}"
