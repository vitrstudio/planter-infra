resource "aws_route53_record" "www" {
  zone_id = var.zone_id
  name    = "www"
  type    = "A"
  ttl     = 60
  records = [var.root_record_ip]
}

resource "aws_route53_record" "root" {
  zone_id = var.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 60
  records = [var.root_record_ip]
}
