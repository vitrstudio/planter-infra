resource "aws_s3_bucket" "redirect" {
  bucket        = "www.${var.domain_name}"
  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "redirect" {
  bucket = aws_s3_bucket.redirect.id

  redirect_all_requests_to {
    host_name = var.domain_name
    protocol  = "https"
  }
}

resource "aws_cloudfront_distribution" "redirect" {
  origin {
    domain_name = "${aws_s3_bucket.redirect.bucket}.s3-website.us-east-1.amazonaws.com"
    origin_id   = "redirect-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id       = "redirect-origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  aliases = ["www.${var.domain_name}"]

  tags = {
    Name = "${var.project_name}-redirect-cdn"
  }

  depends_on = [aws_s3_bucket_website_configuration.redirect]
}
