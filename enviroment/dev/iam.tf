module "registry_role" {
    source         = "../../infra/modules/lambda-iam-role-assume"
    name           = var.name
}

module "registry_policy" {
    source         = "../../infra/modules/lambda-iam-policy"
    name           = var.name
    resource_arn   = module.main.arn
}


module "registry_policy_attachement" {
    source         = "../../infra/modules/lambda-iam-policy-attachement"
    role_name      = module.registry_role.name
    policy_arn     = module.registry_policy.arn

}


module "parameter-ssm-register-role-arn" {
  source         = "../../infra/modules/ssm"
  name           = "register-role-arn"
  type           = "String"     
  value          =  module.registry_role.arn
}