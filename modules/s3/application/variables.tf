variable "project_id" {
  description = "Project unique id"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "certificate_arn" {
  type        = string
  description = "ACM certificate arn for https"
}
