locals {
  policy_vars = {
    aws_partition  = var.aws_partition
    aws_account_id = data.aws_caller_identity.current.account_id
    aws_region     = var.aws_region
    # create a flat json list for iam policy resources
    dynamodb_resources = jsonencode(flatten([for t in var.dynamodb_table_names :
      [
        "arn:${var.aws_partition}:dynamodb:${var.aws_region}:${data.aws_caller_identity.current.account_id}:table/${t}",
        "arn:${var.aws_partition}:dynamodb:${var.aws_region}:${data.aws_caller_identity.current.account_id}:table/${t}/index/*"
      ]
    ]))
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = var.role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "sam_role_policies" {
  for_each = var.sam_policies
  name     = format("%s%s", each.value, join("_", var.dynamodb_table_names))
  role     = aws_iam_role.lambda_role.id
  policy   = templatefile(format("${path.module}/sam_policy_templates/%s.json", each.value), local.policy_vars)
}

resource "aws_iam_role_policy" "custom_lambda_role" {
  for_each = var.custom_policies
  name     = each.key
  role     = aws_iam_role.lambda_role.id
  policy   = jsonencode(each.value)
}
