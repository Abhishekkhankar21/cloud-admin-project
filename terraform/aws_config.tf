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

# Attach AWS managed policy
resource "aws_iam_role_policy_attachment" "config_policy" {
  role       = aws_iam_role.config_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

# Configuration Recorder
resource "aws_config_configuration_recorder" "config_recorder" {
  name     = "cloud-admin-config-recorder"
  role_arn = aws_iam_role.config_role.arn
}

# Delivery Channel
resource "aws_config_delivery_channel" "config_channel" {
  name           = "cloud-admin-config-channel"
  s3_bucket_name = aws_s3_bucket.config_bucket.bucket

  depends_on = [
    aws_config_configuration_recorder.config_recorder,
    aws_s3_bucket_policy.config_bucket_policy
  ]
}

# Start Recorder
resource "aws_config_configuration_recorder_status" "config_status" {
  name       = aws_config_configuration_recorder.config_recorder.name
  is_enabled = true

  depends_on = [aws_config_delivery_channel.config_channel]
}