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

resource "aws_iam_policy" "ec2_deployment_s3_read" {
  name = "${var.project_name}-ec2-deployment-read"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["s3:GetObject", "s3:ListBucket"],
        Resource = [
          aws_s3_bucket.deployment_s3.arn,
          "${aws_s3_bucket.deployment_s3.arn}/*"
        ]
      }
    ]
  })
}
