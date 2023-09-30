module "dynamodb_table" {
  source         = "../../infra/modules/dynamo"
  name           = "${var.enviroment}-${var.api_core}-${var.api_endpoints_register}-table"
  hash_key       =  "id"
  write_capacity = 1
  read_capacity  = 1
  pk_name        = "id"
  pk_type        = "S"
}

module "parameter-ssm-table_name" {
  source         = "../../infra/modules/ssm"
  name           = "${var.enviroment}-parameter-${var.api_core}-${var.api_endpoints_register}-table_name"
  type           = "String"     
  value          =  module.dynamodb_table.table_name
}