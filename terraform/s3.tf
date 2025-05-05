data "aws_s3_bucket" "s3_reference" {
  bucket = "ahmed-magdy-iti"

}

resource "aws_s3_bucket_notification" "s3_event_trigger" {
  bucket = data.aws_s3_bucket.s3_reference.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_event_lambda.arn
    events             = ["s3:ObjectCreated:*"] 
    filter_suffix = ".tfstate"
  }
}