output "api_url" {
  value = format("https://${aws_api_gateway_rest_api.apigateway_announcement_app.id}.execute-api.${var.aws_region}.amazonaws.com/${var.rest_api_stage}", )
}