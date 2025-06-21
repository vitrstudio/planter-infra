output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2.public_ip
}

output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.rds_endpoint
}

output "s3_bucket" {
  value = module.s3.bucket_name
}

output "cloudfront_distribution_url" {
  value = module.s3.cloudfront_domain
}