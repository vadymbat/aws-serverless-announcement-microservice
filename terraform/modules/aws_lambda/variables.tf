variable "aws_region" {
  default = "eu-central-1"
}

variable "common_tags" {
    type = map(string)
    default = {}
}

### Lambda configuration start ###
variable "lambda_name" {
  type = string
  description = "The name of a lambda function"
}

variable "lambda_env_variables" {
  type = map(string)
  description = "(optional) The environment variables available inside the lambda function"
  default = {}
}

variable "lambda_runtime" {
  type = string
  description = "The runtime for the lambda"
}

variable "lambda_handler" {
  type = string
  description = "Entrypoint method in the lambda"
}

variable "lambda_artifacts_bucket" {
  type = string
  description = "S3 bucket where artifact is located"
}

variable "lambda_artifacts_key" {
  type = string
  description = "S3 bucket key of the artifact"
}
### Lambda configuration end ###

### IAM role configuration start ###
variable "dynamodb_table_names" {
  type        = set(string)
  description = "(optional) AWS table name to config access to"
  default     = []
}

variable "iam_path" {
  type        = string
  description = "(optional) IAM path for the role"
  default     = "/"
}

variable "sam_policies" {
  default     = []
  type        = set(string)
  description = "List of SAM policy names from https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-policy-template-list.html"
}

variable "custom_policies" {
  default     = {}
  type        = map(any)
  description = "Map of custom role policies"
}

variable "role_name" {
  type = string
  description = "Lambda role name"
}
### IAM role configuration end ###