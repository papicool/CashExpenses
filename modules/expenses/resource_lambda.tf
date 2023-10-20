
resource "aws_lambda_function" "example_lambda" {
  function_name = "MyLambdaFunction"
  handler      = "index.handler"
  runtime      = "python3.8"
  role         = aws_iam_role.lambda_execution_role.arn

  s3_bucket = "${aws_s3_bucket.website_bucket.bucket}"  # Optional if you want to deploy code from an S3 bucket
  s3_key    = "MyLambdaFunction.zip"   # Optional if you want to deploy code from an S3 bucket

  source_code_hash = filebase64sha256("/workspace/CashExpenses/aws/lambda/MyLambdaFunction.zip")
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_execution_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  roles      = [aws_iam_role.lambda_execution_role.name]
  name = "myLambdaPolicy"
}
