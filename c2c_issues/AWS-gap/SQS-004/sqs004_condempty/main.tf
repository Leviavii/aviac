variable "dlq_arn" {
  type    = string
  default = ""
}

resource "aws_sqs_queue" "sqs004_condempty" {
  name = "c2cgap-sqs004-condempty"
  redrive_policy = var.dlq_arn != "" ? jsonencode({
    deadLetterTargetArn = var.dlq_arn
    maxReceiveCount     = 5
  }) : ""

  tags = {
    Rule = "SQS-004"
  }
}
