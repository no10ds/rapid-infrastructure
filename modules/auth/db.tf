resource "aws_dynamodb_table" "permissions_table" {
  name         = "${var.resource-name-prefix}_users_permissions"
  hash_key     = "PK"
  range_key    = "SK"
  billing_mode = "PAY_PER_REQUEST"


  attribute {
    name = "PK"
    type = "S"
  }

  attribute {
    name = "SK"
    type = "S"
  }

  ttl {
    attribute_name = "TTL"
    enabled        = true
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = var.tags
}

resource "aws_dynamodb_table_item" "data_permissions" {
  table_name = aws_dynamodb_table.permissions_table.name
  hash_key   = aws_dynamodb_table.permissions_table.hash_key
  range_key  = aws_dynamodb_table.permissions_table.range_key

  for_each = var.data_permissions

  item = <<ITEM
      {
        "PK": {"S": "PER#${each.value.type}"},
        "SK": {"S": "PER#${each.key}"},
        "Id": {"S": "${each.key}"},
        "Type": {"S": "${each.value.type}"},
        "Sensitivity": {"S": "${each.value.sensitivity}"}
      }
    ITEM
}

resource "aws_dynamodb_table_item" "admin_permissions" {
  table_name = aws_dynamodb_table.permissions_table.name
  hash_key   = aws_dynamodb_table.permissions_table.hash_key
  range_key  = aws_dynamodb_table.permissions_table.range_key

  for_each = var.admin_permissions

  item = <<ITEM
      {
        "PK": {"S": "PER#${each.value.type}"},
        "SK": {"S": "PER#${each.key}"},
        "Id": {"S": "${each.key}"},
        "Type": {"S": "${each.value.type}"}
      }
    ITEM
}

resource "aws_dynamodb_table_item" "test_client_permissions" {
  table_name = aws_dynamodb_table.permissions_table.name
  hash_key   = aws_dynamodb_table.permissions_table.hash_key
  range_key  = aws_dynamodb_table.permissions_table.range_key

  item     = <<ITEM
  {
    "PK": {"S": "USR#CLIENT"},
    "SK": {"S": "USR#${aws_cognito_user_pool_client.test_client.id}"},
    "Id": {"S": "${aws_cognito_user_pool_client.test_client.id}"},
    "Type": {"S": "Client"},
    "Permissions": {"SS": ["0","1","2","3"]}
  }
  ITEM
}