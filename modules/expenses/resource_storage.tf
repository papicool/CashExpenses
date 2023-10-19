
resource "aws_s3_bucket" "website_bucket" {
  #bucket = var.bucket_name
  tags = {
    UserUuid = var.user_uuid
  }
}

resource "aws_s3_object" "upload_assets" {
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
}