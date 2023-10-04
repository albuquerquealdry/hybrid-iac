module "registry_role" {
    source         = "../../infra/modules/lambda-iam-role-assume"
    name           = "${var.api_core}-${var.api_endpoints_register}-role"
    tags           = var.tags
}

module "registry_policy" {
    source         = "../../infra/modules/lambda-iam-policy"
    name           = "${var.api_core}-${var.api_endpoints_register}-policy"
    resource_arn   = module.dynamodb_table.arn
    tags           = var.tags
}


module "registry_policy_attachement" {
    source         = "../../infra/modules/lambda-iam-policy-attachement"
    role_name      = module.registry_role.name
    policy_arn     = module.registry_policy.arn

}

module "registry_policy_attachement_policy_basic" {
    source         = "../../infra/modules/lambda-iam-policy-attachement"
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