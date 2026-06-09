# SQS-011: SQS Queue public access policy
# Misconfiguration: queue policy allows Principal = "*"

resource "aws_sqs_queue" "sqs011_public_queue" {
  name = "sqs011-public-access-queue"
  # MISCONFIGURATION: policy allows all principals
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "sqs:SendMessage"
        Resource  = "*"
      }
    ]
  })

  tags = {
    Project = "wiz-policy-testing"
  }
}
