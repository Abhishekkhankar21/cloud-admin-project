resource "aws_lambda_function" "auto_tag_lambda" {
  function_name = "auto-tag-resources"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  role = aws_iam_role.lambda_role.arn

  filename = "lambda.zip"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}