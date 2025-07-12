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

module "acm" {
  source      = "./modules/acm"
  domain_name = var.domain_name
  zone_id     = module.hosted_zone.zone_id
}

module "deployment_s3" {
  source       = "./modules/s3/deployment"
  project_name = var.project_name
}

module "app_s3" {
  source          = "./modules/s3/application"
  project_id      = var.project_id
  project_name    = var.project_name
  certificate_arn = module.acm.certificate_arn
  cloudfront_distribution_arn = module.cloudfront.cloudfront_distribution_arn
}

module "ec2" {
  source       = "./modules/ec2"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.public_subnet_id
  ami_id       = var.ami_id
  deployment_s3_bucket_name = module.deployment_s3.bucket_name
  deployment_s3_bucket_arn  = module.deployment_s3.bucket_arn
}

module "cloudfront" {
  source            = "./modules/cloudfront"
  project_name      = var.project_name
  domain_name       = var.domain_name
  certificate_arn   = module.acm.certificate_arn
  api_origin_domain = module.ec2.public_dns
  s3_domain_name    = module.app_s3.bucket_regional_domain_name
  oac_id            = module.app_s3.oac_id
  s3_bucket_id        = module.app_s3.bucket_name
  s3_bucket_arn       = module.app_s3.bucket_arn
}

module "route53" {
  source                  = "./modules/route53"
  project_name            = var.project_name
  domain_name             = var.domain_name
  root_cloudfront_domain  = module.cloudfront.cloudfront_domain
  zone_id                 = module.hosted_zone.zone_id
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
