output "bucket_name" {
  value = aws_s3_bucket.deployment_s3.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.deployment_s3.arn
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.deployment_s3.bucket_regional_domain_name
}

output "deployment_s3_read_policy_arn" {
  description = "IAM policy ARN for EC2 to read from deployment S3 bucket"
  value       = aws_iam_policy.ec2_deployment_s3_read.arn
}
