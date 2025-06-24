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

variable "root_cloudfront_domain" {
  type        = string
  description = "Cloudfront domain for root domain"
}

variable "www_cloudfront_domain" {
  type        = string
  description = "Cloudfront domain for www subdomain"
}
