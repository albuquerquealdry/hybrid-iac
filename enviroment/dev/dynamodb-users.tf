module "dynamodb_table" {
  source         = "../../infra/modules/dynamo"
  name           = "${var.enviroment}-${var.api_core}-${var.api_endpoints_register}-table"
  hash_key       =  "id"
  write_capacity = 1
  read_capacity  = 1
  pk_name        = "id"
  pk_type        = "S"
  tags           = var.tags
  gsi_name       = "${var.enviroment}-${var.api_core}-${var.api_endpoints_register}-email-gsi"
  gsi_key_name   = "email"
  gsi_type       = "S"
}

module "parameter-ssm-table_name" {
  source         = "../../infra/modules/ssm"
  name           = "${var.enviroment}-parameter-${var.api_core}-${var.api_endpoints_register}-table_name"
  type           = "String"     
  value          =  module.dynamodb_table.table_name
  tags           = var.tags
}

module "parameter-ssm-gsi_email" {
  source         = "../../infra/modules/ssm"
  name           = "${var.enviroment}-parameter-${var.api_core}-${var.api_endpoints_register}-gsi_email"
  type           = "String"     
  value          =  "${var.enviroment}-${var.api_core}-${var.api_endpoints_register}-email-gsi"
  tags           = var.tags
}