module "account_a" {
  source = "./account_a"
  aws_account_b = var.aws_account_b
}

module "account_b" {
  source = "./account_b"
  aws_account_a = var.aws_account_a
}
