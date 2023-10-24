resource "aws_sqs_queue" "main" {
  name           =  var.name
  redrive_policy = var.redrive_policy
  policy         = var.policy    
  tags           =  var.tags
}