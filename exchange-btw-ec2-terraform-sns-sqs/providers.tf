provider "aws" {
  region = "us-east-1"
}

variable "aws_account_b" {
  description = "AWS Account B ID"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}
