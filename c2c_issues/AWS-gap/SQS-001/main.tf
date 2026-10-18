locals {
  sqs001_variable_sse_enabled  = false
  sqs001_kmsnullvar_kms_key_id = var.account_id == "" ? var.account_id : null
  sqs001_cond_kms_key_id       = var.account_id == "" ? var.account_id : null
  sqs001_cond_sse_enabled      = false
  sqs001_foreach_queues = {
    orders = {
      sse_enabled = false
    }
  }
}

resource "aws_sqs_queue" "sqs001_explicit" {
  name                    = "c2cgap-sqs001-explicit"
  sqs_managed_sse_enabled = false

  tags = {
    Rule = "SQS-001"
  }
}

resource "aws_sqs_queue" "sqs001_variable" {
  name                    = "c2cgap-sqs001-variable"
  sqs_managed_sse_enabled = local.sqs001_variable_sse_enabled

  tags = {
    Rule = "SQS-001"
  }
}

resource "aws_sqs_queue" "sqs001_kmsnullvar" {
  name                    = "c2cgap-sqs001-kmsnullvar"
  kms_master_key_id       = local.sqs001_kmsnullvar_kms_key_id
  sqs_managed_sse_enabled = false

  tags = {
    Rule = "SQS-001"
  }
}

resource "aws_sqs_queue" "sqs001_foreach" {
  for_each                = local.sqs001_foreach_queues
  name                    = "c2cgap-sqs001-foreach-${each.key}"
  sqs_managed_sse_enabled = each.value.sse_enabled

  tags = {
    Rule = "SQS-001"
  }
}

resource "awscc_sqs_queue" "sqs001_awscc" {
  queue_name              = "c2cgap-sqs001-awscc"
  sqs_managed_sse_enabled = false

  tags = [
    {
      key   = "Rule"
      value = "SQS-001"
    }
  ]
}

resource "aws_sqs_queue" "sqs001_default" {
  name = "c2cgap-sqs001-default"

  tags = {
    Rule = "SQS-001"
  }
}

resource "aws_sqs_queue" "sqs001_cond" {
  name                    = "c2cgap-sqs001-cond"
  kms_master_key_id       = local.sqs001_cond_kms_key_id
  sqs_managed_sse_enabled = local.sqs001_cond_kms_key_id != null ? null : local.sqs001_cond_sse_enabled

  tags = {
    Rule = "SQS-001"
  }
}
