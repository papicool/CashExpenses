
data "archive_file" "zip" {
  type        = "zip"
  source_file = "/workspace/CashExpenses/aws/lambda/MyLambdaFunction.py"
  output_path = "/workspace/CashExpenses/aws/lambda/MyLambdaFunction.zip"
}
data "aws_iam_policy_document" "policy" {
  statement {
    sid    = ""
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}
resource "aws_lambda_function" "lambda" {
  function_name = "MyLambdaFunction"
  filename         = data.archive_file.zip.output_path
  source_code_hash = data.archive_file.zip.output_base64sha256
  role    = aws_iam_role.iam_for_lambda.arn
  handler = "MyLambdaFunction.lambda_handler"
  runtime = "python3.8"
}

# Create an AWS Lambda permission to allow S3 to invoke the Lambda function
resource "aws_lambda_permission" "allow_s3_trigger" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "s3.amazonaws.com"
}

resource "aws_iam_policy" "lambda_cloudwatch_logs_policy" {
  name        = "LambdaCloudWatchLogsPolicy"
  description = "Policy to allow Lambda to write logs to CloudWatch Logs"
  policy      = file("/workspace/CashExpenses/aws/policies/lambda_cloudwatch.json")  # Provide the path to your policy file
}

resource "aws_iam_policy_attachment" "lambda_cloudwatch_logs_attachment" {
  name       = "lambda-cloudwatch-logs-attachment"
  roles      = [aws_iam_role.iam_for_lambda.name]
  policy_arn = aws_iam_policy.lambda_cloudwatch_logs_policy.arn
}

resource "aws_iam_policy" "lambda_rekognition_policy" {
  name        = "LambdaRekognitionPolicy"
  description = "Policy to allow Lambda to do DetectText operation"
  policy      = file("/workspace/CashExpenses/aws/policies/rekognition.json")  # Provide the path to your policy file
}
resource "aws_iam_policy_attachment" "lambda_rekognition_attachment" {
  name       = "lambda-rekognition-attachment"
  roles      = [aws_iam_role.iam_for_lambda.name]
  policy_arn = aws_iam_policy.lambda_rekognition_policy.arn
}