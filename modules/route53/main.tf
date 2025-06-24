resource "aws_route53_record" "root" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = var.root_cloudfront_domain
    zone_id                = "Z2FDTNDATAQYW2" # Cloudfront global zone id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = var.www_cloudfront_domain
    zone_id                = "Z2FDTNDATAQYW2" # Cloudfront global zone id
    evaluate_target_health = false
  }
}
