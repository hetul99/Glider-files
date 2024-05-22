resource "aws_sns_topic" "sns_topic" {
  provider = aws.account_a
  name     = "sns-topic"
}

resource "aws_sns_topic_policy" "sns_policy" {
  provider = aws.account_a
  arn      = aws_sns_topic.sns_topic.arn
  policy   = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.aws_account_b
        }
        Action = "SNS:Publish"
        Resource = aws_sns_topic.sns_topic.arn
      }
    ]
  })
}

output "sns_topic_arn" {
  value = aws_sns_topic.sns_topic.arn
}



resource "aws_sqs_queue" "sqs_queue" {
  provider = aws.account_b
  name     = "sqs-queue"
}

output "sqs_queue_url" {
  value = aws_sqs_queue.sqs_queue.url
}

output "sqs_queue_arn" {
  value = aws_sqs_queue.sqs_queue.arn
}



resource "aws_sns_topic_subscription" "sns_to_sqs" {
  provider  = aws.account_b
  topic_arn = "arn:aws:sns:us-east-1:ACCOUNT_A_ID:sns-topic"  # replace ACCOUNT_A_ID
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sqs_queue.arn
}

