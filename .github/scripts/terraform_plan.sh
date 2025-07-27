#!/bin/bash
set -euo pipefail

terraform plan -out=tfplan \
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
