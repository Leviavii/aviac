locals {
  secret_kms_key_id      = ""
  secret_kms_key_id_null = tostring(null)
}

resource "aws_secretsmanager_secret" "sec003_alias_explicit" {
  name                    = "c2cgap-secret003-alias-explicit"
  kms_key_id              = "alias/aws/secretsmanager"
  recovery_window_in_days = 0

  tags = {
    Rule = "Secret-003"
  }
}

resource "aws_secretsmanager_secret" "sec003_aliasarn_explicit" {
  name                    = "c2cgap-secret003-aliasarn-explicit"
  kms_key_id              = "arn:aws:kms:${var.region}:${var.account_id}:alias/aws/secretsmanager"
  recovery_window_in_days = 0

  tags = {
    Rule = "Secret-003"
  }
}

resource "aws_secretsmanager_secret" "sec003_default" {
  name                    = "c2cgap-secret003-default"
  recovery_window_in_days = 0

  tags = {
    Rule = "Secret-003"
  }
}

resource "aws_secretsmanager_secret" "sec003_emptyvar" {
  name                    = "c2cgap-secret003-emptyvar"
  kms_key_id              = local.secret_kms_key_id
  recovery_window_in_days = 0

  tags = {
    Rule = "Secret-003"
  }
}

data "aws_kms_alias" "sec003_dsalias_key" {
  name = "alias/aws/secretsmanager"
}

resource "aws_secretsmanager_secret" "sec003_dsalias" {
  name                    = "c2cgap-secret003-dsalias"
  kms_key_id              = data.aws_kms_alias.sec003_dsalias_key.arn
  recovery_window_in_days = 0

  tags = {
    Rule = "Secret-003"
  }
}

data "aws_kms_key" "sec003_dskey_key" {
  key_id = "alias/aws/secretsmanager"
}

resource "aws_secretsmanager_secret" "sec003_dskey" {
  name                    = "c2cgap-secret003-dskey"
  kms_key_id              = data.aws_kms_key.sec003_dskey_key.arn
  recovery_window_in_days = 0

  tags = {
    Rule = "Secret-003"
  }
}

resource "awscc_secretsmanager_secret" "sec003_cc_default" {
  name = "c2cgap-secret003-cc-default"

  tags = [{
    key   = "Rule"
    value = "Secret-003"
  }]
}

resource "awscc_secretsmanager_secret" "sec003_cc_alias" {
  name       = "c2cgap-secret003-cc-alias"
  kms_key_id = "alias/aws/secretsmanager"

  tags = [{
    key   = "Rule"
    value = "Secret-003"
  }]
}

resource "aws_secretsmanager_secret" "sec003_nullvar" {
  name                    = "c2cgap-secret003-nullvar"
  kms_key_id              = local.secret_kms_key_id_null
  recovery_window_in_days = 0

  tags = {
    Rule = "Secret-003"
  }
}

resource "aws_kms_key" "sec003_cond_key" {
  count       = false ? 1 : 0
  description = "sec003 optional CMK"

  tags = {
    Rule = "Secret-003"
  }
}

resource "aws_secretsmanager_secret" "sec003_cond" {
  name                    = "c2cgap-secret003-cond"
  kms_key_id              = false ? aws_kms_key.sec003_cond_key[0].arn : null
  recovery_window_in_days = 0

  tags = {
    Rule = "Secret-003"
  }
}
