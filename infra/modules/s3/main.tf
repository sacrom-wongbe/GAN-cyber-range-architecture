terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.66.0"
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "config_initialization" {
  bucket = "${data.aws_caller_identity.current.account_id}-config-initialization-files"

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "config_initialization" {
  bucket = aws_s3_bucket.config_initialization.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "config_initialization" {
  bucket = aws_s3_bucket.config_initialization.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
