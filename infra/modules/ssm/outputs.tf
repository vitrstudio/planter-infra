output "static_website_cloudfront_id_parameter_arn" {
  description = "SSM Parameter ARN for CloudFront distribution ID"
  value       = aws_ssm_parameter.static_website_cloudfront_id.arn
}

output "static_website_cloudfront_id_parameter_name" {
  description = "SSM Parameter name for CloudFront distribution ID"
  value       = aws_ssm_parameter.static_website_cloudfront_id.name
}

output "ec2_instance_id_parameter_arn" {
  description = "SSM Parameter ARN for EC2 instance ID"
  value       = aws_ssm_parameter.ec2_instance_id.arn
}

output "ec2_instance_id_parameter_name" {
  description = "SSM Parameter name for EC2 instance ID"
  value       = aws_ssm_parameter.ec2_instance_id.name
}

output "ec2_public_ip_parameter_arn" {
  description = "SSM Parameter ARN for EC2 public IP"
  value       = aws_ssm_parameter.ec2_public_ip.arn
}

output "ec2_public_ip_parameter_name" {
  description = "SSM Parameter name for EC2 public IP"
  value       = aws_ssm_parameter.ec2_public_ip.name
}

output "rds_endpoint_parameter_arn" {
  description = "SSM Parameter ARN for RDS endpoint"
  value       = aws_ssm_parameter.rds_endpoint.arn
}

output "rds_endpoint_parameter_name" {
  description = "SSM Parameter name for RDS endpoint"
  value       = aws_ssm_parameter.rds_endpoint.name
}

output "deployment_bucket_parameter_arn" {
  description = "SSM Parameter ARN for deployment bucket"
  value       = aws_ssm_parameter.deployment_bucket.arn
}

output "deployment_bucket_parameter_name" {
  description = "SSM Parameter name for deployment bucket"
  value       = aws_ssm_parameter.deployment_bucket.name
}

output "github_role_arn_parameter_arn" {
  description = "SSM Parameter ARN for GitHub role ARN"
  value       = aws_ssm_parameter.github_role_arn.arn
}

output "github_role_arn_parameter_name" {
  description = "SSM Parameter name for GitHub role ARN"
  value       = aws_ssm_parameter.github_role_arn.name
} 