module "parameter-ssm" {
  source         = "../../infra/modules/ssm"
  name           = "users-table"
  type           = "String"     
  value          =  var.name

}