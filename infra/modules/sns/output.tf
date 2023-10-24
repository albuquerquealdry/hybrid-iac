output "name" {
  description = "The ID of the created instance"
  value       = aws_sns_topic.main.name
}

output "arn" {
  description = "The ID of the created instance"
  value       = aws_sns_topic.main.arn
}