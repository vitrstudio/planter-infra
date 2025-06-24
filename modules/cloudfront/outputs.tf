output "cloudfront_domain" {
  value = aws_cloudfront_distribution.api_cdn.domain_name
}
