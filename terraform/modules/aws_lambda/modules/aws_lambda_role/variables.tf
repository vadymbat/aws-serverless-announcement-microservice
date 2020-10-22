variable "aws_partition" {
  type        = string
  description = "(optional) AWS Partition"
  default     = "aws"
}

variable "aws_region" {
  default = "eu-central-1"
}

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
variable "role_name" {
  type    = string
  default = ""
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
