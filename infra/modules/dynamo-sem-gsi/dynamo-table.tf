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
}