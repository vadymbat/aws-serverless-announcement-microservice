output "function_arn" {
  value = aws_lambda_function.lambda_function.arn
}

output "function_api_integration_uri" {
  value = format("arn:aws:apigateway:%s:lambda:path/2015-03-31/functions/%s/invocations", var.aws_region, aws_lambda_function.lambda_function.arn)
}