variable "sqs004_modv4_redrive_policy" {
  type    = any
  default = {}
}

resource "aws_sqs_queue" "sqs004_modv4" {
  name                       = "c2cgap-sqs004-modv4"
  visibility_timeout_seconds = 30

  tags = {
    Rule = "SQS-004"
  }
}

resource "aws_sqs_queue_redrive_policy" "sqs004_modv4_redrive" {
  count          = length(var.sqs004_modv4_redrive_policy) > 0 ? 1 : 0
  queue_url      = aws_sqs_queue.sqs004_modv4.url
  redrive_policy = jsonencode(var.sqs004_modv4_redrive_policy)
}
