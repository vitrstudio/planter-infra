output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2_api.public_ip
}

output "ec2_instance_id" {
  description = "Instance ID of the EC2 instance"
  value       = module.ec2_api.instance_id
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

output "github_role_arn" {
  value = module.iam_github.github_role_arn
}