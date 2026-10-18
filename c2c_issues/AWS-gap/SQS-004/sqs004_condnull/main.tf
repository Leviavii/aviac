variable "dlq_arn" {
  type    = string
  default = ""
}

resource "aws_sqs_queue" "sqs004_condnull" {
  name = "c2cgap-sqs004-condnull"
  redrive_policy = var.dlq_arn != "" ? jsonencode({
    deadLetterTargetArn = var.dlq_arn
    maxReceiveCount     = 5
  }) : null

  tags = {
    Rule = "SQS-004"
  }
}
