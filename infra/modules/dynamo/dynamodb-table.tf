resource "aws_dynamodb_table" "main" {
    name     =  var.name
    hash_key =  var.hash_key
    attribute {
        name = var.pk_name
        type = var.pk_type
    } 
    write_capacity = var.write_capacity
    read_capacity  = var.read_capacity
    tags = var.tags

    attribute {
        name = var.gsi_key_name
        type = var.gsi_type
    }
    global_secondary_index {
      name            = var.gsi_name
      projection_type = "ALL"
      hash_key        = var.gsi_key_name
      write_capacity  = var.write_capacity
      read_capacity   = var.read_capacity
    }
}