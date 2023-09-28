module "main" {
  source         = "../../infra/modules/dynamo"
  name           = "users-table"
  hash_key       =  "id"
  write_capacity = 1
  read_capacity  = 1
  pk_name        = "id"
  pk_type        = "S"
}