module "hosted_zone" {
  source      = "./modules/route53_hosted_zone_persisted"
  domain_name = var.domain_name
}