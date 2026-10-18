resource "aws_cloudwatch_log_group" "cw035_omitted" {
  name              = "c2cgap-cw035-omitted"
  retention_in_days = 30

  tags = {
    Rule = "CloudWatch-035"
  }
}

resource "aws_cloudwatch_log_group" "cw035_null" {
  name              = "c2cgap-cw035-null"
  retention_in_days = 30
  kms_key_id        = null

  tags = {
    Rule = "CloudWatch-035"
  }
}

resource "aws_cloudwatch_log_group" "cw035_empty" {
  name              = "c2cgap-cw035-empty"
  retention_in_days = 30
  kms_key_id        = ""

  tags = {
    Rule = "CloudWatch-035"
  }
}

resource "aws_cloudwatch_log_group" "cw035_varnull" {
  name              = "c2cgap-cw035-varnull"
  retention_in_days = 30
  kms_key_id        = local.cw035_varnull_log_kms_key_id

  tags = {
    Rule = "CloudWatch-035"
  }
}

resource "aws_cloudwatch_log_group" "cw035_varempty" {
  name              = "c2cgap-cw035-varempty"
  retention_in_days = 30
  kms_key_id        = local.cw035_varempty_log_kms_key_arn

  tags = {
    Rule = "CloudWatch-035"
  }
}

resource "aws_kms_key" "cw035_cond_key" {
  count               = false ? 1 : 0
  description         = "cw035 log key"
  enable_key_rotation = true

  tags = {
    Rule = "CloudWatch-035"
  }
}

resource "aws_cloudwatch_log_group" "cw035_cond" {
  name              = "c2cgap-cw035-cond"
  retention_in_days = 30
  kms_key_id        = false ? aws_kms_key.cw035_cond_key[0].arn : null

  tags = {
    Rule = "CloudWatch-035"
  }
}

resource "awscc_logs_log_group" "cw035_awscc" {
  log_group_name    = "c2cgap-cw035-awscc"
  retention_in_days = 30

  tags = [
    {
      key   = "Rule"
      value = "CloudWatch-035"
    }
  ]
}

locals {
  cw035_varnull_log_kms_key_id   = tostring(null)
  cw035_varempty_log_kms_key_arn = ""
  cw035_local_kms_key_arn        = false ? aws_kms_key.cw035_cond_key[0].arn : null
}

resource "aws_cloudwatch_log_group" "cw035_local" {
  name              = "c2cgap-cw035-local"
  retention_in_days = 30
  kms_key_id        = local.cw035_local_kms_key_arn

  tags = {
    Rule = "CloudWatch-035"
  }
}
