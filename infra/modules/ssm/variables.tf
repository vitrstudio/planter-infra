variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "static_website_cloudfront_id" {
  description = "CloudFront distribution ID for static website"
  type        = string
}

variable "ec2_instance_id" {
  description = "EC2 instance ID"
  type        = string
}

variable "ec2_public_ip" {
  description = "EC2 public IP address"
  type        = string
}

variable "rds_endpoint" {
  description = "RDS endpoint"
  type        = string
}

variable "deployment_bucket" {
  description = "Deployment S3 bucket name"
  type        = string
}

variable "github_role_arn" {
  description = "GitHub role ARN"
  type        = string
} 