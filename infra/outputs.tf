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
  value       = aws_ssm_parameter.static_website_cloudfront_id.arn
}

output "ec2_instance_id_ssm_parameter_arn" {
  description = "SSM Parameter ARN for EC2 instance ID"
  value       = aws_ssm_parameter.ec2_instance_id.arn
}

output "ec2_public_ip_ssm_parameter_arn" {
  description = "SSM Parameter ARN for EC2 public IP"
  value       = aws_ssm_parameter.ec2_public_ip.arn
}

output "rds_endpoint_ssm_parameter_arn" {
  description = "SSM Parameter ARN for RDS endpoint"
  value       = aws_ssm_parameter.rds_endpoint.arn
}

output "deployment_bucket_ssm_parameter_arn" {
  description = "SSM Parameter ARN for deployment bucket"
  value       = aws_ssm_parameter.deployment_bucket.arn
}

output "github_role_arn_ssm_parameter_arn" {
  description = "SSM Parameter ARN for GitHub role ARN"
  value       = aws_ssm_parameter.github_role_arn.arn
}
