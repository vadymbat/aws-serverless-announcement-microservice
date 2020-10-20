variable "aws_partition" {
  type = string
  description = "(optional) describe your variable"
  default = ""
}

variable "aws_account_id" {
  type = string
  description = "(optional) describe your variable"
}

variable "aws_dynamodb_table_name" {
  type = string
  description = "(optional) describe your variable"
  default = ""
}

variable "sam_policies" {
  type = list(string)
  description = "List of SAM policy names from https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-policy-template-list.html"
}
