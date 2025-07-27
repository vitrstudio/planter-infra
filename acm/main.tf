terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.5.0"
    }
  }
}

resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  subject_alternative_names = [
    "www.${var.domain_name}",
    "api.${var.domain_name}"
  ]
  validation_method = "DNS"
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = var.hosted_zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}
