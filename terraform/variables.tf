variable "aws_region" {
  default = "eu-central-1"
}

variable "application_name" {
    type = string
    description = ""
    default = "announcement_app"
}

variable "rest_api_stage" {
    type = string
    description = ""
}

variable "lambda_log_level" {
    type = string
    default = "DEBUG"
}