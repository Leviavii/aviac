variable "sqs004_varempty_redrive_policy" {
  type    = string
  default = ""
}

resource "aws_sqs_queue" "sqs004_varempty" {
  name           = "c2cgap-sqs004-varempty"
  redrive_policy = var.sqs004_varempty_redrive_policy

  tags = {
    Rule = "SQS-004"
  }
}
