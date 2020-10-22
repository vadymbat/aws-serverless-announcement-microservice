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