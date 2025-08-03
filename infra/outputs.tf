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

output "github_role_arn" {
  value = module.iam_github.github_role_arn
}

output "static_website_cloudfront_id" {
  description = "CloudFront distribution ID for static website"
  value       = module.static_website_cloudfront.cloudfront_distribution_id
}

output "static_website_cloudfront_id_ssm_parameter_arn" {
  description = "SSM Parameter ARN for CloudFront distribution ID"
  value       = module.ssm_parameters.static_website_cloudfront_id_parameter_arn
}

output "ec2_instance_id_ssm_parameter_arn" {
  description = "SSM Parameter ARN for EC2 instance ID"
  value       = module.ssm_parameters.ec2_instance_id_parameter_arn
}

output "ec2_public_ip_ssm_parameter_arn" {
  description = "SSM Parameter ARN for EC2 public IP"
  value       = module.ssm_parameters.ec2_public_ip_parameter_arn
}

output "rds_endpoint_ssm_parameter_arn" {
  description = "SSM Parameter ARN for RDS endpoint"
  value       = module.ssm_parameters.rds_endpoint_parameter_arn
}

output "deployment_bucket_ssm_parameter_arn" {
  description = "SSM Parameter ARN for deployment bucket"
  value       = module.ssm_parameters.deployment_bucket_parameter_arn
}

output "github_role_arn_ssm_parameter_arn" {
  description = "SSM Parameter ARN for GitHub role ARN"
  value       = module.ssm_parameters.github_role_arn_parameter_arn
}
