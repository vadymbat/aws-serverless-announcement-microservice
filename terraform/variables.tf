variable "aws_region" {
  default = "eu-central-1"
}

variable "application_name" {
  type        = string
  description = "Application name wich will added to resources names"
  default     = "announcement-app"
}

variable "rest_api_stage" {
  type        = string
  description = "Api gateway stage name"
  default     = "dev"
}

variable "lambda_artifact_s3_bucket" {
  type        = string
  description = "The s3 bucket where"
  default     = "aws-serverless-announcement-microservice"
}

variable "lambda_artifact_name" {
  type        = string
  description = "The s3 bucket where"
  default     = "announcement-app.zip"
}

variable "lambda_log_level" {
  type    = string
  default = "DEBUG"
}

variable "dynamodb_announcements_table_name" {
  type    = string
  default = "AnnouncementsTable"
}

variable "intial_tags" {
  type = map(string)
  default = {
    "ManagedBy" = "terraform",
  }
}