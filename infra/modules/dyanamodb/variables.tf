variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = "user-configuration"
}

variable "histories_table_name" {
  description = "Name of the user histories DynamoDB table"
  type        = string
  default     = "user-histories"
}

variable "results_table_name" {
  description = "Name of the user results DynamoDB table"
  type        = string
  default     = "user-results"
}

variable "tags" {
  description = "Common tags for created resources"
  type        = map(string)
  default     = {}
}
