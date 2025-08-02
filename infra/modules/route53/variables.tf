variable "project_name" {
  description = "Project name"
  type        = string
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
}

variable "zone_id" {
  type        = string
  description = "Hosted zone id"
}

variable "api_cloudfront_domain" {
  type        = string
  description = "Cloudfront domain for api subdomain"
}

variable "static_website_cloudfront_domain" {
  type        = string
  description = "Cloudfront domain for static website subdomain"
}
