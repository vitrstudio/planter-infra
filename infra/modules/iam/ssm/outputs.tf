output "ssm_profile_name" {
  description = "The name of the SSM instance profile for EC2 instances"
  value       = aws_iam_instance_profile.ec2_ssm.name
}

output "ssm_role_name" {
  description = "The name of the SSM instance profile for EC2 instances"
  value       = aws_iam_role.ec2_ssm.name
}
