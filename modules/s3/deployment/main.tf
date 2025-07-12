resource "aws_s3_bucket" "deployment_s3" {
  bucket = "${var.project_name}-deployments"

  tags = {
    Name = "${var.project_name}-deployment-bucket"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.deployment_s3.id

  rule {
    id     = "auto-delete-old-deployments"
    status = "Enabled"

    filter {
      prefix = "deployments/"
    }

    expiration {
      days = 1
    }
  }
}
