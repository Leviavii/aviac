locals {
  sqs002_var_alias_kms_key_id                 = "alias/aws/sqs"
  sqs002_module_style_kms_master_key_id       = null
  sqs002_module_style_sqs_managed_sse_enabled = true
}

resource "aws_sqs_queue" "sqs002_aws_managed_alias" {
  name                              = "c2cgap-sqs002-aws-managed-alias"
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300

  tags = {
    Rule = "SQS-002"
  }
}

resource "aws_sqs_queue" "sqs002_default_omitted" {
  name = "c2cgap-sqs002-default-omitted"

  tags = {
    Rule = "SQS-002"
  }
}

resource "aws_sqs_queue" "sqs002_sse_sqs_explicit" {
  name                    = "c2cgap-sqs002-sse-sqs-explicit"
  sqs_managed_sse_enabled = true

  tags = {
    Rule = "SQS-002"
  }
}

resource "aws_sqs_queue" "sqs002_sse_disabled" {
  name                    = "c2cgap-sqs002-sse-disabled"
  sqs_managed_sse_enabled = false

  tags = {
    Rule = "SQS-002"
  }
}

resource "awscc_sqs_queue" "sqs002cc_aws_managed_alias" {
  queue_name                        = "c2cgap-sqs002cc-aws-managed-alias"
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300

  tags = [
    {
      key   = "Rule"
      value = "SQS-002"
    }
  ]
}

resource "awscc_sqs_queue" "sqs002cc_default_omitted" {
  queue_name = "c2cgap-sqs002cc-default-omitted"

  tags = [
    {
      key   = "Rule"
      value = "SQS-002"
    }
  ]
}

resource "aws_sqs_queue" "sqs002_var_alias" {
  name              = "c2cgap-sqs002-var-alias"
  kms_master_key_id = local.sqs002_var_alias_kms_key_id

  tags = {
    Rule = "SQS-002"
  }
}

resource "aws_sqs_queue" "sqs002_module_style" {
  name                    = "c2cgap-sqs002-module-style"
  kms_master_key_id       = local.sqs002_module_style_kms_master_key_id
  sqs_managed_sse_enabled = local.sqs002_module_style_kms_master_key_id != null ? null : local.sqs002_module_style_sqs_managed_sse_enabled

  tags = {
    Rule = "SQS-002"
  }
}

resource "aws_sqs_queue" "sqs002_empty_key_id" {
  name              = "c2cgap-sqs002-empty-key-id"
  kms_master_key_id = ""

  tags = {
    Rule = "SQS-002"
  }
}
