output "sns_topic_arn" {
  value = module.account_a.sns_topic_arn
}

output "s3_bucket_name" {
  value = module.account_a.s3_bucket_name
}

output "sqs_queue_url" {
  value = module.account_b.sqs_queue_url
}

output "sqs_queue_arn" {
  value = module.account_b.sqs_queue_arn
}
