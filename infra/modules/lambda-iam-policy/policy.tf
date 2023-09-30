resource "aws_iam_policy" "register_policy" {
  name        = "${var.name}-policy"
  path        = "/"
  description = "My test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
        ]
        Effect   = "Allow"
        Resource = "${var.resource_arn}"
      },
    ]
  })
}