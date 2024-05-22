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

resource "aws_s3_bucket" "bucket" {
  provider = aws.account_a
  bucket   = "message-log-bucket"
  acl      = "private"
}

output "sns_topic_arn" {
  value = aws_sns_topic.sns_topic.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.id
}
