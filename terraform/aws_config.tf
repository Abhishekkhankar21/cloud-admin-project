# S3 bucket for AWS Config
resource "aws_s3_bucket" "config_bucket" {
  bucket = "cloud-admin-config-bucket-unique123"
  force_destroy = true
}

# Allow AWS Config to write to the bucket
resource "aws_s3_bucket_policy" "config_bucket_policy" {
  bucket = aws_s3_bucket.config_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "config.amazonaws.com"
        }
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.config_bucket.arn}/*"
      },
      {
        Effect = "Allow"
        Principal = {
          Service = "config.amazonaws.com"
        }
        Action = "s3:GetBucketAcl"
        Resource = aws_s3_bucket.config_bucket.arn
      }
    ]
  })
}

# IAM Role
resource "aws_iam_role" "config_role" {
  name = "cloud-admin-config-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "config.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

