terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.66.0"
    }
  }
}

resource "aws_dynamodb_table" "user_configuration" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"
  range_key    = "batchid"

  attribute {
    name = "userId"
    type = "N"
  }

  attribute {
    name = "batchid"
    type = "N"
  }

  tags = var.tags
}

resource "aws_dynamodb_table" "user_histories" {
  name         = var.histories_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"
  range_key    = "batchid"

  attribute {
    name = "userId"
    type = "N"
  }

  attribute {
    name = "batchid"
    type = "N"
  }

  tags = var.tags
}

resource "aws_dynamodb_table" "user_results" {
  name         = var.results_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"
  range_key    = "batchid"

  attribute {
    name = "userId"
    type = "N"
  }

  attribute {
    name = "batchid"
    type = "N"
  }

  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  tags = var.tags
}
