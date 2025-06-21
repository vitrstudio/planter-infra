#!/bin/bash

export "$(grep -v '^#' .env | xargs)"
set -e

terraform destroy -auto-approve \
  -var="region=$REGION" \
  -var="project_id=$PROJECT_ID" \
  -var="project_name=$PROJECT_NAME" \
  -var="ami_id=$AMI_ID" \
  -var="db_name=$DB_NAME" \
  -var="db_user=$DB_USERNAME" \
  -var="db_password=$PLANTER_DB_PASSWORD"