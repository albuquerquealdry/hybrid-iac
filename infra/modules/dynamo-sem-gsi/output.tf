output "arn" {
  description = "The ID of the created instance"
  value       = aws_dynamodb_table.main.arn
}

output "table_name" {
  description = "The ID of the created instance"
  value       = aws_dynamodb_table.main.name
}