output "name" {
  description = "The ID of the created instance"
  value       = aws_sqs_queue.main.name
}

output "arn" {
  description = "The ID of the created instance"
  value       = aws_sqs_queue.main.arn
}
