locals{
  policy_vars = {
    aws_partition = var.aws_partition
    aws_account_id = data.aws_caller_identity.current.account_id
    aws_region = var.aws_region
    aws_dynamodb_table_name = var.aws_dynamodb_table_name
  }
}

resource "aws_iam_role" "lambda_role" {
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

resource "aws_iam_policy" "sam_role_policies" {
  for_each = var.sam_policies
  name        = var.iam_policy_name
  path        = "/"
  role = aws_iam_role.lambda_role.id
  policy = templatefile(format("policy_templates/%s.json", var.policy_vars))
}

resource "aws_iam_role_policy" "custom_lambda_role" {
    name = ""
    role = aws_iam_role.example-iam-role.id

}