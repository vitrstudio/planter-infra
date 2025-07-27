#!/bin/bash
set -e

put_param() {
  local name=$1
  local value=$2
  local type=${3:-"String"}

  if aws ssm get-parameter --name "$name" --region "$AWS_DEFAULT_REGION" > /dev/null 2>&1; then
    echo "Updating $name"
    aws ssm put-parameter \
      --name "$name" \
      --value "$value" \
      --type "$type" \
      --overwrite \
      --region "$AWS_DEFAULT_REGION"
  else
    echo "Creating $name"
    aws ssm put-parameter \
      --name "$name" \
      --value "$value" \
      --type "$type" \
      --region "$AWS_DEFAULT_REGION"
  fi
}

put_param planter/ec2_instance_id "$1"
put_param planter/ec2_public_ip "$2"
put_param planter/rds_endpoint "$3"
put_param planter/deployment_bucket "$4"
put_param planter/github_role_arn "$5"
