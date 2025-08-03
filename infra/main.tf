module "iam_github" {
  source          = "./modules/iam/github"
  project_name    = var.project_name
  github_repo     = "vitrstudio/${var.project_name}"
}

module "iam_ssm" {
  source = "./modules/iam/ssm"
  project_name = var.project_name
}

module "deployment_s3" {
  source       = "./modules/s3/deployment"
  project_name = var.project_name
}

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  azs          = ["${var.region}a", "${var.region}b"]
}

module "nacl" {
  source             = "./modules/nacl"
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.vpc.public_subnet_id
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "route53" {
  source                  = "./modules/route53"
  project_name            = var.project_name
  domain_name             = var.domain_name
  api_cloudfront_domain  = module.api_cloudfront.cloudfront_domain
  static_website_cloudfront_domain  = module.static_website_cloudfront.cloudfront_domain
  zone_id                 = var.hosted_zone_id
}

module "api_cloudfront" {
  source            = "./modules/cloudfront/api"
  project_name      = var.project_name
  domain_name       = var.domain_name
  certificate_arn   = var.certificate_arn
  api_origin_domain = module.ec2_api.public_dns
}

module "ec2_api" {
  source       = "./modules/ec2/api"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.public_subnet_id
  ami_id       = var.ami_id
  deployment_s3_bucket_name = module.deployment_s3.bucket_name
  ssm_profile_name = module.iam_ssm.ssm_profile_name
  ssm_role_name    = module.iam_ssm.ssm_role_name
}

module "rds" {
  source             = "./modules/rds"
  project_id         = var.project_id
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  ec2_cidr_block     = "10.0.1.0/24"
  db_name            = var.db_name
  db_user            = var.db_user
  db_password        = var.db_password
}

module "ec2_bastion" {
  source = "./modules/ec2/bastion"
  project_name         = var.project_name
  vpc_id               = module.vpc.vpc_id
  public_subnet_id     = module.vpc.public_subnet_id
  ami_id               = var.ami_id
  key_name             = var.project_name
  ssm_profile_name     = module.iam_ssm.ssm_profile_name
}

module "static_website_cloudfront" {
  source            = "./modules/cloudfront/staticwebsite"
  project_name      = var.project_name
  domain_name       = var.domain_name
  certificate_arn   = var.certificate_arn
  s3_domain_name    = module.app_s3.bucket_regional_domain_name
  oac_id            = module.app_s3.oac_id
  s3_bucket_id        = module.app_s3.bucket_name
  s3_bucket_arn       = module.app_s3.bucket_arn
}

module "app_s3" {
  source          = "./modules/s3/staticwebsite"
  project_id      = var.project_id
  project_name    = var.project_name
  certificate_arn = var.certificate_arn
  cloudfront_distribution_arn = module.static_website_cloudfront.cloudfront_distribution_arn
}

# SSM parameters
resource "aws_ssm_parameter" "static_website_cloudfront_id" {
  name  = "/${var.project_name}/static_website_cloudfront_id"
  type  = "String"
  value = module.static_website_cloudfront.cloudfront_distribution_id

  tags = {
    Name = "${var.project_name}-static-website-cloudfront-id"
  }
}

resource "aws_ssm_parameter" "ec2_instance_id" {
  name  = "/${var.project_name}/ec2_instance_id"
  type  = "String"
  value = module.ec2_api.instance_id

  tags = {
    Name = "${var.project_name}-ec2-instance-id"
  }
}

resource "aws_ssm_parameter" "ec2_public_ip" {
  name  = "/${var.project_name}/ec2_public_ip"
  type  = "String"
  value = module.ec2_api.public_ip

  tags = {
    Name = "${var.project_name}-ec2-public-ip"
  }
}

resource "aws_ssm_parameter" "rds_endpoint" {
  name  = "/${var.project_name}/rds_endpoint"
  type  = "String"
  value = module.rds.rds_endpoint

  tags = {
    Name = "${var.project_name}-rds-endpoint"
  }
}

resource "aws_ssm_parameter" "deployment_bucket" {
  name  = "/${var.project_name}/deployment_bucket"
  type  = "String"
  value = module.deployment_s3.bucket_name

  tags = {
    Name = "${var.project_name}-deployment-bucket"
  }
}

resource "aws_ssm_parameter" "github_role_arn" {
  name  = "/${var.project_name}/github_role_arn"
  type  = "String"
  value = module.iam_github.github_role_arn

  tags = {
    Name = "${var.project_name}-github-role-arn"
  }
}
