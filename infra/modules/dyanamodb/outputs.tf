output "user_config_table_name" {
  description = "Name of the user configuration DynamoDB table"
  value       = aws_dynamodb_table.user_configuration.name
}

output "user_config_table_arn" {
  description = "ARN of the user configuration DynamoDB table"
  value       = aws_dynamodb_table.user_configuration.arn
}

output "user_histories_table_name" {
  description = "Name of the user histories DynamoDB table"
  value       = aws_dynamodb_table.user_histories.name
}

output "user_histories_table_arn" {
  description = "ARN of the user histories DynamoDB table"
  value       = aws_dynamodb_table.user_histories.arn
}

output "user_results_table_name" {
  description = "Name of the user results DynamoDB table"
  value       = aws_dynamodb_table.user_results.name
}

output "user_results_table_arn" {
  description = "ARN of the user results DynamoDB table"
  value       = aws_dynamodb_table.user_results.arn
}

output "user_results_stream_arn" {
  description = "Stream ARN of the user results DynamoDB table"
  value       = aws_dynamodb_table.user_results.stream_arn
}
