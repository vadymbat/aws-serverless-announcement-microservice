terraform {
  required_version = ">=0.12.29"
}

provider "aws" {
  region = var.aws_region
}

module "aws_lambda_create_announcement" {
  source               = "./modules/aws_lambda"
  # iam configuration
  role_name            = "CreateAnnouncementLambdaRole"
  aws_region           = var.aws_region
  sam_policies         = ["DynamoDBCrudPolicy"]
  dynamodb_table_names = ["AnnouncementsTable"]
  
  # lambda configuration
  lambda_name = "create-announcement"
  lambda_artifacts_bucket = "announcement-app-aritfacts"
  lambda_artifacts_key = "announcement-app.zip"
  lambda_runtime = "python3.7"
  lambda_handler = "handler.create_announcement"
  lambda_env_variables = {
    "ANNOUNCEMENT_TABLE_NAME" = "AnnouncementsTable",
    "LOG_LEVEL" = "DEBUG"
  }
}

module "aws_lambda_list_announcements" {
  source               = "./modules/aws_lambda"
  # iam configuration
  role_name            = "ListAnnouncementsLambdaRole"
  aws_region           = var.aws_region
  sam_policies         = ["DynamoDBCrudPolicy"]
  dynamodb_table_names = ["AnnouncementsTable"]

  # lambda configuration
  lambda_name = "list-announcements"
  lambda_artifacts_bucket = "announcement-app-aritfacts"
  lambda_artifacts_key = "announcement-app.zip"
  lambda_runtime = "python3.7"
  lambda_handler = "handler.list_announcements"
  lambda_env_variables = {
    "ANNOUNCEMENT_TABLE_NAME" = "AnnouncementsTable",
    "LOG_LEVEL" = "DEBUG"
  }
}
