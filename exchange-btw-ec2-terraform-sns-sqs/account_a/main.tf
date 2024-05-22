module "account_a" {
  source = "./account_a"
  aws_account_b = var.aws_account_b
}
