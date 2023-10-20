output "bucket_name" {
  value = aws_s3_bucket.website_bucket.bucket
}

output "lambda" {
  value = aws_lambda_function.lambda.qualified_arn
}