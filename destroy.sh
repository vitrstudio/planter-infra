#!/bin/bash

# Load environment variables
export "$(grep -v '^#' .env | xargs)"
set -e

# Init backend with same key (important for destroy)
terraform init \
  -backend-config="bucket=codefarm-terraform-states" \
  -backend-config="key=users/${GITHUB_USER}/${PROJECT_NAME}/terraform.tfstate" \
  -backend-config="region=${AWS_REGION}" \
  -backend-config="encrypt=true"

# Destroy infrastructure
terraform destroy -auto-approve \
  -var="region=${AWS_REGION}" \
  -var="project_id=${PROJECT_ID}" \
  -var="project_name=${PROJECT_NAME}" \
  -var="ami_id=${AMI_ID}" \
  -var="db_name=${DB_NAME}" \
  -var="db_user=${DB_USERNAME}" \
  -var="db_password=${PLANTER_DB_PASSWORD}"