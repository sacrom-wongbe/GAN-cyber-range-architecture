terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.66.0"
    }
  }
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.tags, {
    Name = "gan-cyber-range-vpc"
  })
}

resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge(var.tags, {
    Name = "gan-cyber-range-subnet"
  })
}

data "aws_availability_zones" "available" {
  state = "available"
}

# Security Group for Optimization Lambda
resource "aws_security_group" "optimization_lambda" {
  name        = "optimization-lambda-sg"
  description = "Security group for optimization Lambda"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "optimization-lambda-sg"
  })
}

# Security Group for Initializer Lambda
resource "aws_security_group" "initializer_lambda" {
  name        = "initializer-lambda-sg"
  description = "Security group for initializer Lambda"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "initializer-lambda-sg"
  })
}

# Security Group for Cognitive Lambda
resource "aws_security_group" "cognitive_lambda" {
  name        = "cognitive-lambda-sg"
  description = "Security group for cognitive Lambda"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "cognitive-lambda-sg"
  })
}

# Security Group for Aggregator Lambda
resource "aws_security_group" "aggregator_lambda" {
  name        = "aggregator-lambda-sg"
  description = "Security group for aggregator Lambda"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "aggregator-lambda-sg"
  })
}
