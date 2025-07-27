#!/bin/bash
set -e

echo "ec2_instance_id=$(terraform output -raw ec2_instance_id)" >> $GITHUB_OUTPUT
echo "ec2_public_ip=$(terraform output -raw ec2_public_ip)" >> $GITHUB_OUTPUT
echo "app_s3_bucket=$(terraform output -raw app_s3_bucket_name)" >> $GITHUB_OUTPUT
echo "deployment_bucket=$(terraform output -raw deployment_s3_bucket_name)" >> $GITHUB_OUTPUT
echo "cloudfront_url=$(terraform output -raw cloudfront_distribution_url)" >> $GITHUB_OUTPUT
echo "rds_endpoint=$(terraform output -raw rds_endpoint)" >> $GITHUB_OUTPUT
echo "github_role_arn=$(terraform output -raw github_role_arn)" >> $GITHUB_OUTPUT
