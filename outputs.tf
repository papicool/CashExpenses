output "bucket_name" {
  description = "bucket_name from our static website"
  value = module.cashExpenses.bucket_name
}


output "lambda" {
  description = "my lambda"
  value = module.cashExpenses.lambda
}