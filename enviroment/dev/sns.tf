module "notification_sns" {
    source = "../../infra/modules/sns"
    name   = "${var.enviroment}-notification-sns"
    tags   = var.tags
}