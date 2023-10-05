resource "aws_iam_role" "register_role" {
  name = "${var.name}-role"

  assume_role_policy = var.policy_data
  tags = var.tags
}