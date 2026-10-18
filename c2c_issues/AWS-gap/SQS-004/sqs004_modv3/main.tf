variable "sqs004_modv3_redrive_policy" {
  type    = string
  default = ""
}

variable "sqs004_modv3_redrive_allow_policy" {
  type    = string
  default = ""
}

resource "aws_sqs_queue" "sqs004_modv3" {
  name                       = "c2cgap-sqs004-modv3"
  visibility_timeout_seconds = 30
  redrive_policy             = var.sqs004_modv3_redrive_policy
  redrive_allow_policy       = var.sqs004_modv3_redrive_allow_policy

  tags = {
    Rule = "SQS-004"
  }
}
