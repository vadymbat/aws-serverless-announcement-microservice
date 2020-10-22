locals{
  lambda_integration_uris = {
    lambda_integration_uri_create_announcement = module.aws_lambda_create_announcement.function_api_integration_uri,
    lambda_integration_uri_list_announcements = module.aws_lambda_list_announcements.function_api_integration_uri
  }
}
terraform {
  required_version = ">=0.12.29"
}

provider "aws" {
  region = var.aws_region
  max_retries = 10
}

module "aws_lambda_create_announcement" {
  source = "./modules/aws_lambda"
  
  # iam configuration
  role_name            = "CreateAnnouncementLambdaRole"
  aws_region           = var.aws_region
  sam_policies         = ["DynamoDBCrudPolicy"]
  dynamodb_table_names = [var.dynamodb_announcements_table_name]

  # lambda configuration
  lambda_name             = "create-announcement"
  lambda_artifacts_bucket = "announcement-app-aritfacts"
  lambda_artifacts_key    = "announcement-app.zip"
  lambda_runtime          = "python3.7"
  lambda_handler          = "handler.create_announcement"
  lambda_env_variables = {
    "ANNOUNCEMENT_TABLE_NAME" = var.dynamodb_announcements_table_name,
    "LOG_LEVEL"               = "DEBUG"
  }
}

module "aws_lambda_list_announcements" {
  source = "./modules/aws_lambda"
  
  # iam configuration
  role_name            = "ListAnnouncementsLambdaRole"
  aws_region           = var.aws_region
  sam_policies         = ["DynamoDBCrudPolicy"]
  dynamodb_table_names = [var.dynamodb_announcements_table_name]

  # lambda configuration
  lambda_name             = "list-announcements"
  lambda_artifacts_bucket = "announcement-app-aritfacts"
  lambda_artifacts_key    = "announcement-app.zip"
  lambda_runtime          = "python3.7"
  lambda_handler          = "handler.list_announcements"
  lambda_env_variables = {
    "ANNOUNCEMENT_TABLE_NAME" = var.dynamodb_announcements_table_name,
    "LOG_LEVEL"               = "DEBUG"
  }
}

resource "aws_api_gateway_rest_api" "apigateway_announcement_app" {
  name = "announcement-app"
  body = templatefile("./templates/swagger.yaml", local.lambda_integration_uris)
}

resource "aws_api_gateway_deployment" "apigateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.apigateway_announcement_app.id
  stage_name  = "test"
}

resource "aws_api_gateway_stage" "apigateway_stage" {
  stage_name    = var.rest_api_stage
  rest_api_id   = aws_api_gateway_rest_api.apigateway_announcement_app.id
  deployment_id = aws_api_gateway_deployment.apigateway_deployment.id
}

resource "aws_lambda_permission" "lambda_create_announcement" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = module.aws_lambda_create_announcement.function_arn
   principal     = "apigateway.amazonaws.com"
   source_arn = "${aws_api_gateway_rest_api.apigateway_announcement_app.execution_arn}/*/*"
}

resource "aws_lambda_permission" "lambda_list_announcements" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = module.aws_lambda_list_announcements.function_arn
   principal     = "apigateway.amazonaws.com"
   source_arn = "${aws_api_gateway_rest_api.apigateway_announcement_app.execution_arn}/*/*"
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = var.dynamodb_announcements_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

}