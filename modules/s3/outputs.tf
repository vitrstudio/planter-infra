output "bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.website.bucket
}

output "bucket_regional_domain_name" {
  description = "S3 bucket regional domain for CloudFront origin"
  value       = aws_s3_bucket.website.bucket_regional_domain_name
}

output "oac_id" {
  description = "Origin Access Control ID"
  value       = aws_cloudfront_origin_access_control.oac.id
}
