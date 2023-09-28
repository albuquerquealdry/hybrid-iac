output "arn" {
  description = "The ID of the created instance"
  value       = aws_dynamodb_table.main.arn
}
