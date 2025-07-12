variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "Vpc id"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet id"
  type        = string
}

variable "ami_id" {
  description = "Ami id"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "user_data" {
  description = "Startup script to run on ec2 instance"
  type        = string
  default     = ""
}

variable "deployment_s3_bucket_name" {
  description = "Name of the S3 bucket for deployment artifacts"
  type        = string
}

variable "deployment_s3_read_policy_arn" {
    description = "IAM policy ARN for EC2 to read from deployment S3 bucket"
    type        = string
}
