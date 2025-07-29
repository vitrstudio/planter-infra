variable "project_name" {
  type        = string
  description = "Project name for tagging"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "public_subnet_id" {
  type        = string
  description = "Subnet for bastion host"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance type"
}

variable "key_name" {
  type        = string
  description = "SSH key name for EC2 access"
}

variable "ssm_profile_name" {
  description = "The name of the SSM instance profile for EC2 instances"
  type        = string
}
