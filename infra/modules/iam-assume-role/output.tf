output "name" {
  description = "The ID of the created instance"
  value       = aws_iam_role.register_role.name
}

output "arn" {
  description = "The ID of the created instance"
  value       = aws_iam_role.register_role.arn
}
