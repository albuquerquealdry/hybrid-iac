
module "parameter-ssm-jwt_secret" {
  source         = "../../infra/modules/ssm"
  name           = "${var.enviroment}-parameter-jwt-secret"
  type           = "String"     
  value          =  var.jwt_secret
  tags           = var.tags
}