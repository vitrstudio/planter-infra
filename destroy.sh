#!/bin/bash

set -a
source .env
set +a

terraform init \
  -backend-config="bucket=codefarm-terraform-states" \
  -backend-config="key=users/${GITHUB_USER}/${PROJECT_NAME}/terraform.tfstate" \
  -backend-config="region=${AWS_REGION}" \
  -backend-config="encrypt=true"

terraform destroy -auto-approve \
  -var="region=${AWS_REGION}" \
  -var="project_id=${PROJECT_ID}" \
  -var="project_name=${PROJECT_NAME}" \
  -var="domain_name=${DOMAIN_NAME}" \
  -var="ami_id=${AMI_ID}" \
  -var="db_name=${DB_NAME}" \
  -var="db_user=${DB_USERNAME}" \
  -var="db_password=${DB_PASSWORD}"
