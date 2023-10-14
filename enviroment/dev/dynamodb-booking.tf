module "dynamodb_table_booking" {
  source         = "../../infra/modules/dynamo-sem-gsi"
  name           = "${var.enviroment}-${var.api_core_booking}-table"
  hash_key       =  "id"
  write_capacity = 1
  read_capacity  = 1
  pk_name        = "id"
  pk_type        = "S"
  tags           = var.tags
}

module "parameter-ssm-table_name_booking" {
  source         = "../../infra/modules/ssm"
  name           = "${var.enviroment}-parameter-${var.api_core_booking}-table_name"
  type           = "String"     
  value          =  module.dynamodb_table_booking.table_name
  tags           = var.tags
}