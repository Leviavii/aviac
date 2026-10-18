variable "sqs004_varnull_redrive_policy" {
  type    = string
  default = null
}

resource "aws_sqs_queue" "sqs004_varnull" {
  name           = "c2cgap-sqs004-varnull"
  redrive_policy = var.sqs004_varnull_redrive_policy

  tags = {
    Rule = "SQS-004"
  }
}
