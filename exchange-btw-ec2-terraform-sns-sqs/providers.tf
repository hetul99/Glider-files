provider "aws" {
  alias  = "account_a"
  region = "us-east-1"
}

variable "aws_account_b" {
  description = "AWS Account B ID"
  type        = string
}

provider "aws" {
  alias  = "account_b"
  region = "us-east-1"
}

variable "aws_account_a" {
  description = "AWS Account A ID"
  type        = string
}
