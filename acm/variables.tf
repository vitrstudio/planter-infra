variable "domain_name" {
  description = "The root domain name"
  type        = string
}

variable "region" {
    description = "AWS region"
    type        = string
}

variable "hosted_zone_id" {
  description = "The hosted zone id"
  type        = string
}
