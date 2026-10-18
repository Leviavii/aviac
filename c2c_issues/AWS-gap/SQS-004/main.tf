resource "aws_sqs_queue" "sqs004_omitted" {
  name                       = "c2cgap-sqs004-omitted"
  visibility_timeout_seconds = 30
  message_retention_seconds  = 345600

  tags = {
    Rule = "SQS-004"
  }
}

resource "aws_sqs_queue" "sqs004_emptystring" {
  name           = "c2cgap-sqs004-emptystring"
  redrive_policy = ""

  tags = {
    Rule = "SQS-004"
  }
}

module "sqs004_condnull" {
  source = "./sqs004_condnull"
}

module "sqs004_condempty" {
  source = "./sqs004_condempty"
}

resource "aws_sqs_queue" "sqs004_inlinedenyall" {
  name = "c2cgap-sqs004-inlinedenyall"
  redrive_allow_policy = jsonencode({
    redrivePermission = "denyAll"
  })

  tags = {
    Rule = "SQS-004"
  }
}

resource "aws_sqs_queue" "sqs004_separatedenyall" {
  name = "c2cgap-sqs004-separatedenyall"

  tags = {
    Rule = "SQS-004"
  }
}

resource "aws_sqs_queue_redrive_allow_policy" "sqs004_separatedenyall_allow" {
  queue_url = aws_sqs_queue.sqs004_separatedenyall.id
  redrive_allow_policy = jsonencode({
    redrivePermission = "denyAll"
  })
}

resource "aws_sqs_queue" "sqs004_unuseddlq" {
  name = "c2cgap-sqs004-unuseddlq"
  redrive_allow_policy = jsonencode({
    redrivePermission = "allowAll"
  })

  tags = {
    Rule = "SQS-004"
  }
}

resource "awscc_sqs_queue" "sqs004_awscc" {
  queue_name               = "c2cgap-sqs004-awscc"
  message_retention_period = 345600
  visibility_timeout       = 30

  tags = [
    {
      key   = "Rule"
      value = "SQS-004"
    }
  ]
}

resource "aws_sqs_queue" "sqs004_explicitnull" {
  name           = "c2cgap-sqs004-explicitnull"
  redrive_policy = null

  tags = {
    Rule = "SQS-004"
  }
}

module "sqs004_varempty" {
  source = "./sqs004_varempty"
}

module "sqs004_modv3" {
  source = "./sqs004_modv3"
}

module "sqs004_modv4" {
  source = "./sqs004_modv4"
}

module "sqs004_varnull" {
  source = "./sqs004_varnull"
}
