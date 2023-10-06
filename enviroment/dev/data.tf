### REGISTRY MODULE

data "aws_iam_policy_document" "role_policy_dynamodb_registry" {
  statement {
    sid = "1"

    actions = [
        "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "policy_dynamodb_lambda_registry" {

  statement {
    sid = "SidToOverride"

    actions = ["dynamodb:PutItem"]

    resources = [
        "${module.dynamodb_table.arn}"
    ]
  }
}

### LOGIN MODULE

data "aws_iam_policy_document" "role_policy_dynamodb_login" {
  statement {
    sid = "1"

    actions = [
        "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "policy_dynamodb_lambda_login" {

  statement {
    sid = "SidToOverride"

    actions = ["dynamodb:Query", "dynamodb:GetItem" ]

    resources = [
        "${module.dynamodb_table.arn}",
        "${module.dynamodb_table.arn}/index/${var.enviroment}-${var.api_core}-${var.api_endpoints_register}-email-gsi"
    ]
  }
}