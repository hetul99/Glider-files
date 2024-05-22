variable "aws_account_a" {
  description = "AWS Account A ID"
  type        = string
}

variable "aws_account_b" {
  description = "AWS Account B ID"
  type        = string
}

variable "profile_account_a" {
  description = "AWS CLI profile for Account A"
  type        = string
  default     = "default"
}

variable "profile_account_b" {
  description = "AWS CLI profile for Account B"
  type        = string
  default     = "default"
}
