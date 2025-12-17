variable "region" {
  type    = string
  default = "us-west-2"
}

variable "state_bucket_name" {
  type    = string
  default = "cyberrange-terraform-state-bucket"
}

variable "environment" {
  type    = string
  default = "prod"
}