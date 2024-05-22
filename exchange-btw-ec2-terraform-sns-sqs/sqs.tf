resource "aws_sqs_queue" "sqs_queue" {
  provider = aws.account_b
  name     = "sqs-queue"
}

resource "aws_sns_topic_subscription" "sns_to_sqs" {
  provider  = aws.account_b
  topic_arn = "arn:aws:sns:us-east-1:ACCOUNT_A_ID:sns-topic"  # replace ACCOUNT_A_ID
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sqs_queue.arn
}

output "sqs_queue_url" {
  value = aws_sqs_queue.sqs_queue.url
}

output "sqs_queue_arn" {
  value = aws_sqs_queue.sqs_queue.arn
}
