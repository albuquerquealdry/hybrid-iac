### REGISTRY MODULE

module "registry_role" {
    source         = "../../infra/modules/iam-assume-role"
    name           = "${var.api_core}-${var.api_endpoints_register}"
    tags           = var.tags
    policy_data    = data.aws_iam_policy_document.role_policy_dynamodb_registry.json
}

module "registry_policy" {
    source         = "../../infra/modules/iam-policy"
    name           = "${var.api_core}-${var.api_endpoints_register}"
    policy         =  data.aws_iam_policy_document.policy_dynamodb_lambda_registry.json
    tags           = var.tags
}

module "registry_policy_attachement" {
    source         = "../../infra/modules/iam-policy-attachement"
    role_name      = module.registry_role.name
    policy_arn     = module.registry_policy.arn

}

module "registry_policy_attachement_policy_basic_registry" {
    source         = "../../infra/modules/iam-policy-attachement"
    role_name      = module.registry_role.name
    policy_arn     = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}

module "parameter-ssm-register-role-arn" {
  source         = "../../infra/modules/ssm"
  name           = "${var.enviroment}-parameter-${var.api_core}-${var.api_endpoints_register}-register-role-arn"
  type           = "String"     
  value          =  module.registry_role.arn
tags             = var.tags
}

### LOGIN MODULE

module "login_role" {
    source         = "../../infra/modules/iam-assume-role"
    name           = "${var.api_core}-${var.api_endpoints_login}"
    tags           = var.tags
    policy_data    = data.aws_iam_policy_document.role_policy_dynamodb_login.json
}

module "login_policy" {
    source         = "../../infra/modules/iam-policy"
    name           = "${var.api_core}-${var.api_endpoints_login}"
    policy         =  data.aws_iam_policy_document.policy_dynamodb_lambda_login.json
    tags           = var.tags
}

module "login_policy_attachement" {
    source         = "../../infra/modules/iam-policy-attachement"
    role_name      = module.login_role.name
    policy_arn     = module.login_policy.arn

}

module "registry_policy_attachement_policy_basic_login" {
    source         = "../../infra/modules/iam-policy-attachement"
    role_name      = module.registry_role.name
    policy_arn     = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}

module "parameter-ssm-login-role-arn" {
  source         = "../../infra/modules/ssm"
  name           = "${var.enviroment}-parameter-${var.api_core}-${var.api_endpoints_login}-login-role-arn"
  type           = "String"     
  value          =  module.registry_role.arn
tags             = var.tags
}
