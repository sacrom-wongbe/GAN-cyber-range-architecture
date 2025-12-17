variable "function_name" {
	description = "Lambda function name."
	type        = string
}

variable "subnet_id" {
	description = "VPC subnet for the Lambda."
	type        = string
}

variable "security_group_id" {
	description = "Security group to attach to the Lambda."
	type        = string
}

variable "tags" {
	description = "Common tags for created resources."
	type        = map(string)
	default     = {}
}

variable "environment_variables" {
	description = "Environment variables for the Lambda function."
	type        = map(string)
	default     = {}
}
