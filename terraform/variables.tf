variable "aws_region" {
  default = "eu-central-1"
}

variable "application_name" {
    type = string
    description = "Application name wich will added to resources names"
    default = "announcement_app"
}

variable "rest_api_stage" {
    type = string
    description = "Api gateway stage name"
    default = "dev"
}

variable "lambda_log_level" {
    type = string
    default = "DEBUG"
}