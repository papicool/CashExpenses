
resource "aws_s3_bucket" "website_bucket" {
  #bucket = var.bucket_name

}

/* resource "aws_s3_object" "upload_assets" {
  # https://developer.hashicorp.com/terraform/language/functions/fileset
  # https://developer.hashicorp.com/terraform/language/meta-arguments/for_each
  for_each = fileset("${var.public_path}/assets/", "*.{jpeg,jpg,png,gif}")
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "assets/${each.key}"
  source = "${var.public_path}/assets/${each.key}"
  #content_type = "text/html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("${var.public_path}/assets/${each.key}")
  lifecycle {
    ignore_changes = [etag]
  }
} */

# Create an S3 event notification to trigger the Lambda function when an object is created
resource "aws_s3_bucket_notification" "example_notification" {
  bucket = aws_s3_bucket.website_bucket.bucket

  lambda_function {
    lambda_function_arn = aws_lambda_function.lambda.arn
    events              = ["s3:ObjectCreated:*"]
    #filter_prefix       = "your-prefix/"  # Optional: Filter objects by prefix
  }
}