resource "aws_ssm_parameter" "static_website_cloudfront_id" {
  name      = "/${var.project_name}/static_website_cloudfront_id"
  type      = "String"
  value     = var.static_website_cloudfront_id
  overwrite = true

  tags = {
    Name = "${var.project_name}-static-website-cloudfront-id"
  }
}

resource "aws_ssm_parameter" "ec2_instance_id" {
  name      = "/${var.project_name}/ec2_instance_id"
  type      = "String"
  value     = var.ec2_instance_id
  overwrite = true

  tags = {
    Name = "${var.project_name}-ec2-instance-id"
  }
}

resource "aws_ssm_parameter" "ec2_public_ip" {
  name      = "/${var.project_name}/ec2_public_ip"
  type      = "String"
  value     = var.ec2_public_ip
  overwrite = true

  tags = {
    Name = "${var.project_name}-ec2-public-ip"
  }
}

resource "aws_ssm_parameter" "rds_endpoint" {
  name      = "/${var.project_name}/rds_endpoint"
  type      = "String"
  value     = var.rds_endpoint
  overwrite = true

  tags = {
    Name = "${var.project_name}-rds-endpoint"
  }
}

resource "aws_ssm_parameter" "deployment_bucket" {
  name      = "/${var.project_name}/deployment_bucket"
  type      = "String"
  value     = var.deployment_bucket
  overwrite = true

  tags = {
    Name = "${var.project_name}-deployment-bucket"
  }
}

resource "aws_ssm_parameter" "github_role_arn" {
  name      = "/${var.project_name}/github_role_arn"
  type      = "String"
  value     = var.github_role_arn
  overwrite = true

  tags = {
    Name = "${var.project_name}-github-role-arn"
  }
} 