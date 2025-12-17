output "bucket_name" {
  description = "Name of the config initialization S3 bucket"
  value       = aws_s3_bucket.config_initialization.bucket
}

output "bucket_arn" {
  description = "ARN of the config initialization S3 bucket"
  value       = aws_s3_bucket.config_initialization.arn
}

output "bucket_id" {
  description = "ID of the config initialization S3 bucket"
  value       = aws_s3_bucket.config_initialization.id
}
