terraform {
	required_providers {
		archive = {
			source  = "hashicorp/archive"
			version = ">= 2.4.0"
		}
		aws = {
			source  = "hashicorp/aws"
			version = ">= 5.66.0"
		}
	}
}

data "archive_file" "package" {
	type        = "zip"
	source_file = "${path.module}/cognitive_handler.py"
	output_path = "${path.module}/cognitive_handler.zip"
}

data "aws_iam_policy_document" "assume_role" {
	statement {
		actions = ["sts:AssumeRole"]

		principals {
			type        = "Service"
			identifiers = ["lambda.amazonaws.com"]
		}
	}
}

resource "aws_iam_role" "lambda_role" {
	name               = "${var.function_name}-exec-role"
	assume_role_policy = data.aws_iam_policy_document.assume_role.json

	tags = var.tags
}

resource "aws_iam_role_policy_attachment" "basic_execution" {
	role       = aws_iam_role.lambda_role.name
	policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "vpc_access" {
	role       = aws_iam_role.lambda_role.name
	policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy" "dynamodb_access" {
	count = length(var.dynamodb_table_arns) > 0 ? 1 : 0

	role = aws_iam_role.lambda_role.name

	policy = jsonencode({
		Version = "2012-10-17"
		Statement = [
			{
				Effect = "Allow"
				Action = [
					"dynamodb:GetItem",
					"dynamodb:Query",
					"dynamodb:Scan",
					"dynamodb:PutItem",
					"dynamodb:UpdateItem",
					"dynamodb:DeleteItem"
				]
				Resource = var.dynamodb_table_arns
			}
		]
	})
}

resource "aws_lambda_function" "this" {
	function_name = var.function_name
	role          = aws_iam_role.lambda_role.arn

	filename         = data.archive_file.package.output_path
	source_code_hash = data.archive_file.package.output_base64sha256

	handler = "cognitive_handler.lambda_handler"
	runtime = "python3.12"

	timeout     = 30
	memory_size = 256

	vpc_config {
		subnet_ids         = [var.subnet_id]
		security_group_ids = [var.security_group_id]
	}

	environment {
		variables = var.environment_variables
	}

	tags = var.tags
}
