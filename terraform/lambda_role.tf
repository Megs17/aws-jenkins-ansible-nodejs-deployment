resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach AWSLambdaBasicExecutionRole (Required for Lambda to log to CloudWatch)
resource "aws_iam_policy_attachment" "lambda_basic_execution" {
  name       = "lambda_basic_execution"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

  # Attach SES Full Access Policy
  resource "aws_iam_policy_attachment" "ses_full_access" {
    name       = "ses_full_access"
    roles      = [aws_iam_role.lambda_role.name]
    policy_arn = "arn:aws:iam::aws:policy/AmazonSESFullAccess"
  }

  # Attach S3 Read-Only Access Policy
  resource "aws_iam_policy_attachment" "s3_read_only" {
    name       = "s3_read_only"
    roles      = [aws_iam_role.lambda_role.name]
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }