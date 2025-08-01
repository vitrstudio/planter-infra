output "bucket_name" {
  value = aws_s3_bucket.deployment_s3.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.deployment_s3.arn
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.deployment_s3.bucket_regional_domain_name
}
