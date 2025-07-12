output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2.public_ip
}

output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.rds_endpoint
}

output "app_s3_bucket_name" {
  value = module.app_s3.bucket_name
}

output "deployment_s3_bucket_name" {
  value = module.deployment_s3.bucket_name
}

output "cloudfront_distribution_url" {
  value = module.cloudfront.cloudfront_domain
}