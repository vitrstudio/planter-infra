output "cloudfront_domain" {
  value = aws_cloudfront_distribution.static_cdn.domain_name
}

output "cloudfront_distribution_arn" {
  value = aws_cloudfront_distribution.static_cdn.arn
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.static_cdn.id
}
