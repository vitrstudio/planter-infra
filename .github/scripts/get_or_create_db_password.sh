#!/bin/bash
set -e

if [ -z "$PROJECT_NAME" ]; then
  echo "Error: PROJECT_NAME is not set"
  exit 1
fi

SECRET_NAME="/${PROJECT_NAME}/db_password"

PASSWORD=$(aws ssm get-parameter \
  --name "$SECRET_NAME" \
  --with-decryption \
  --region "$AWS_DEFAULT_REGION" \
  --query "Parameter.Value" \
  --output text 2>/dev/null || true)

if [ -z "$PASSWORD" ]; then
  PASSWORD=$(openssl rand -base64 32 | tr -dc 'A-Za-z0-9' | head -c 20)
  aws ssm put-parameter \
    --name "$SECRET_NAME" \
    --value "$PASSWORD" \
    --type "SecureString" \
    --region "$AWS_DEFAULT_REGION"
fi

echo "DB_PASSWORD=$PASSWORD" >> $GITHUB_ENV
