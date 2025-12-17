output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = aws_subnet.main.id
}

output "optimization_lambda_sg_id" {
  description = "Security group ID for optimization Lambda"
  value       = aws_security_group.optimization_lambda.id
}

output "initializer_lambda_sg_id" {
  description = "Security group ID for initializer Lambda"
  value       = aws_security_group.initializer_lambda.id
}

output "cognitive_lambda_sg_id" {
  description = "Security group ID for cognitive Lambda"
  value       = aws_security_group.cognitive_lambda.id
}

output "aggregator_lambda_sg_id" {
  description = "Security group ID for aggregator Lambda"
  value       = aws_security_group.aggregator_lambda.id
}
