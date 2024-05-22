provider "aws" {
  alias  = "account_a"
  region = "us-east-1"
  profile = var.profile_account_a
}

provider "aws" {
  alias  = "account_b"
  region = "us-east-1"
  profile = var.profile_account_b
}

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
