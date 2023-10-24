module "sqs_email" {
    source         = "../../infra/modules/sqs"
    name           = "${var.enviroment}-${var.api_core_booking}-email-sqs"
    redrive_policy = jsonencode({
            deadLetterTargetArn = module.sqs_email_dlq.arn
            maxReceiveCount     = 3
    })
    tags           = var.tags
    policy         = data.aws_iam_policy_document.policy_sqs_email.json
}

module "sqs_email_dlq" {
    source         = "../../infra/modules/sqs"
    name           = "${var.enviroment}-${var.api_core_booking}-email-sqs-dlq"
    tags           = var.tags
}

module "sqs_sms" {
    source         = "../../infra/modules/sqs"
    name           = "${var.enviroment}-${var.api_core_booking}-sms-sqs"
    tags           = var.tags
    redrive_policy = jsonencode({
        deadLetterTargetArn = module.sqs_sms_dlq.arn
        maxReceiveCount     = 3
    })
}

module "sqs_sms_dlq" {
    source         = "../../infra/modules/sqs"
    name           = "${var.enviroment}-${var.api_core_booking}-sms-sqs-dlq"
    tags           = var.tags
}