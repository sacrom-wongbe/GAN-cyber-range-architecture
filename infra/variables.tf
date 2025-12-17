variable "region" {
  description = "The AWS region to deploy the resources in."
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "optimization_lambda_name" {
  description = "Name of the optimization Lambda function."
  type        = string
  default     = "optimization-lambda"
}

variable "initializer_lambda_name" {
  description = "Name of the initializer Lambda function."
  type        = string
  default     = "initializer-lambda"
}

variable "cognitive_lambda_name" {
  description = "Name of the cognitive Lambda function."
  type        = string
  default     = "cognitive-lambda"
}

variable "aggregator_lambda_name" {
  description = "Name of the aggregator Lambda function."
  type        = string
  default     = "aggregator-lambda"
}

variable "user_config_table_name" {
  description = "Name of the user configuration DynamoDB table."
  type        = string
  default     = "user-configuration"
}
