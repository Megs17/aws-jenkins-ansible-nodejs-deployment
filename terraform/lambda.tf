resource "aws_lambda_function" "s3_event_lambda" {
  function_name = "S3StateFileChangeNotifier"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"

  filename         = "lambda_function.zip"
  source_code_hash = filebase64sha256("lambda_function.zip")

}
resource "aws_lambda_permission" "allow_s3_to_invoke" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  principal     = "s3.amazonaws.com"
  source_arn    = data.aws_s3_bucket.s3_reference.arn
  function_name = aws_lambda_function.s3_event_lambda.function_name
}
