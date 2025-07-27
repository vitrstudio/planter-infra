variable "region" {
  description = "AWS region"
  type        = string
}

variable "project_id" {
  description = "Project unique id"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "ami_id" {
  description = "Ec2 ami id"
  type        = string
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_user" {
  type        = string
  description = "Database username"
}

variable "db_password" {
  type        = string
  description = "Database password"
  sensitive   = true
}

variable "domain_name" {
  description = "The root domain name"
  type        = string
}

variable "hosted_zone_id" {
    description = "The ID of the hosted zone in Route53"
    type        = string
}

variable "certificate_arn" {
    description = "The arn of the acm certificate for the domain"
    type        = string
}
