variable "api_origin_domain" {
  description = "Public DNS or IP of the EC2 backend (e.g. api.farmify.app or IP)"
  type        = string
}

variable "certificate_arn" {
  description = "ACM Certificate ARN for CloudFront"
  type        = string
}

variable "domain_name" {
  description = "Domain name (e.g. farmify.app)"
  type        = string
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
}
