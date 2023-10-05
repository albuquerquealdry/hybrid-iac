resource "aws_iam_policy" "register_policy" {
  name        = "${var.name}-policy"
  path        = "/"
  description = "My test policy"

  policy = var.policy
  tags   = var.tags
}