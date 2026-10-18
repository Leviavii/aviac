locals {
  ddbvarpitr_enabled     = false
  ddbdynamicpitr_enabled = false
}

resource "aws_dynamodb_table" "ddbexplicitfalse" {
  name         = "c2cgap-dynamodb003-ddbexplicitfalse"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }

  point_in_time_recovery {
    enabled = false
  }

  tags = {
    Rule = "DynamoDB-003"
  }
}

resource "aws_dynamodb_table" "ddbomitted" {
  name         = "c2cgap-dynamodb003-ddbomitted"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }

  tags = {
    Rule = "DynamoDB-003"
  }
}

resource "aws_dynamodb_table" "ddbvarpitr" {
  name         = "c2cgap-dynamodb003-ddbvarpitr"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }

  point_in_time_recovery {
    enabled = local.ddbvarpitr_enabled
  }

  tags = {
    Rule = "DynamoDB-003"
  }
}

resource "aws_dynamodb_table" "ddbdynamicpitr" {
  name         = "c2cgap-dynamodb003-ddbdynamicpitr"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }

  dynamic "point_in_time_recovery" {
    for_each = local.ddbdynamicpitr_enabled ? [1] : []
    content {
      enabled = true
    }
  }

  tags = {
    Rule = "DynamoDB-003"
  }
}

resource "awscc_dynamodb_table" "ccddbexplicitfalse" {
  table_name   = "c2cgap-dynamodb003-ccddbexplicitfalse"
  billing_mode = "PAY_PER_REQUEST"
  key_schema = jsonencode([{
    AttributeName = "UserId"
    KeyType       = "HASH"
  }])
  attribute_definitions = [{
    attribute_name = "UserId"
    attribute_type = "S"
  }]
  point_in_time_recovery_specification = {
    point_in_time_recovery_enabled = false
  }

  tags = [
    {
      key   = "Rule"
      value = "DynamoDB-003"
    }
  ]
}

resource "awscc_dynamodb_table" "ccddbomitted" {
  table_name   = "c2cgap-dynamodb003-ccddbomitted"
  billing_mode = "PAY_PER_REQUEST"
  key_schema = jsonencode([{
    AttributeName = "UserId"
    KeyType       = "HASH"
  }])
  attribute_definitions = [{
    attribute_name = "UserId"
    attribute_type = "S"
  }]

  tags = [
    {
      key   = "Rule"
      value = "DynamoDB-003"
    }
  ]
}
