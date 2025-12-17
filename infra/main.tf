terraform {
  required_version = ">= 1.4"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.66.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = ">= 2.4.0"
    }
  }

  backend "s3" {
    bucket         = "138384855579-cyberrange-terraform-state-bucket"
    key            = "infra/terraform.tfstate"
    region         = "us-west-2"
    use_lockfile = true
  }
}

provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

module "networking" {
  source = "./modules/networking"

  vpc_cidr   = var.vpc_cidr
  subnet_cidr = var.subnet_cidr

  tags = {
    Project = "GAN-cyber-range-architecture"
    Module  = "networking"
  }
}

module "dynamodb" {
  source = "./modules/dyanamodb"

  table_name = var.user_config_table_name

  tags = {
    Project = "GAN-cyber-range-architecture"
    Module  = "dynamodb"
  }
}

module "s3" {
  source = "./modules/s3"

  tags = {
    Project = "GAN-cyber-range-architecture"
    Module  = "s3"
  }
}

module "optimization_lambda" {
  source = "./modules/lambda/optimization_lambda"

  function_name      = var.optimization_lambda_name
  subnet_id          = module.networking.subnet_id
  security_group_id  = module.networking.optimization_lambda_sg_id

  tags = {
    Project = "GAN-cyber-range-architecture"
    Module  = "optimization-lambda"
  }
}

module "cognitive_lambda" {
  source = "./modules/lambda/cognitive_lambda"

  function_name       = var.cognitive_lambda_name
  subnet_id           = module.networking.subnet_id
  security_group_id   = module.networking.cognitive_lambda_sg_id
  dynamodb_table_arns = [
    module.dynamodb.user_config_table_arn,
    module.dynamodb.user_histories_table_arn,
    module.dynamodb.user_results_table_arn
  ]

  environment_variables = {
    USER_CONFIG_TABLE    = module.dynamodb.user_config_table_name
    USER_HISTORIES_TABLE = module.dynamodb.user_histories_table_name
    USER_RESULTS_TABLE   = module.dynamodb.user_results_table_name
  }

  tags = {
    Project = "GAN-cyber-range-architecture"
    Module  = "cognitive-lambda"
  }
}

module "initializer_lambda" {
  source = "./modules/lambda/initializer_lambda"

  function_name       = var.initializer_lambda_name
  subnet_id           = module.networking.subnet_id
  security_group_id   = module.networking.initializer_lambda_sg_id
  s3_bucket_arn       = module.s3.bucket_arn
  s3_bucket_id        = module.s3.bucket_id
  dynamodb_table_arns = [
    module.dynamodb.user_config_table_arn,
    module.dynamodb.user_histories_table_arn
  ]

  environment_variables = {
    USER_CONFIG_TABLE    = module.dynamodb.user_config_table_name
    USER_HISTORIES_TABLE = module.dynamodb.user_histories_table_name
    CONFIG_BUCKET        = module.s3.bucket_name
  }

  tags = {
    Project = "GAN-cyber-range-architecture"
    Module  = "initializer-lambda"
  }
}

module "aggregator_lambda" {
  source = "./modules/lambda/aggregator_lambda"

  function_name       = var.aggregator_lambda_name
  subnet_id           = module.networking.subnet_id
  security_group_id   = module.networking.aggregator_lambda_sg_id
  dynamodb_table_arns = [
    module.dynamodb.user_results_table_arn
  ]
  dynamodb_stream_arn = module.dynamodb.user_results_stream_arn

  environment_variables = {
    USER_RESULTS_TABLE = module.dynamodb.user_results_table_name
  }

  tags = {
    Project = "GAN-cyber-range-architecture"
    Module  = "aggregator-lambda"
  }
}
