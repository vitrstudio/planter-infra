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

module "ec2" {
  source       = "./modules/ec2"
  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.public_subnet_id
  ami_id       = var.ami_id
}

module "s3" {
  source          = "./modules/s3"
  project_id      = var.project_id
  project_name    = var.project_name
  certificate_arn = module.acm.certificate_arn
}

module "redirect" {
  source          = "./modules/redirect"
  domain_name     = var.domain_name
  certificate_arn = module.acm.certificate_arn
  project_name    = var.project_name
}

module "cloudfront" {
  source           = "./modules/cloudfront"
  project_name     = var.project_name
  domain_name      = var.domain_name
  certificate_arn  = module.acm.certificate_arn
  api_origin_domain = module.ec2.public_dns
}

module "route53" {
  source                  = "./modules/route53"
  project_name            = var.project_name
  domain_name             = var.domain_name
  root_cloudfront_domain  = module.cloudfront.cloudfront_domain
  www_cloudfront_domain   = module.redirect.redirect_domain
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
