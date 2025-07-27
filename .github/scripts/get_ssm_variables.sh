#!/bin/bash
set -euo pipefail

ZONE_ID=$(aws ssm get-parameter \
  --name "/${PROJECT_NAME}/hosted_zone_id" \
  --with-decryption \
  --region "${AWS_DEFAULT_REGION}" \
  --query "Parameter.Value" \
  --output text)

CERT_ARN=$(aws ssm get-parameter \
  --name "/${PROJECT_NAME}/certificate_arn" \
  --with-decryption \
  --region "${AWS_DEFAULT_REGION}" \
  --query "Parameter.Value" \
  --output text)

echo "HOSTED_ZONE_ID=$ZONE_ID" >> "$GITHUB_ENV"
echo "CERTIFICATE_ARN=$CERT_ARN" >> "$GITHUB_ENV"