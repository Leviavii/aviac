locals {
  kms013_var_off_enable_rotation = false
}

resource "aws_kms_key" "kms013_explicit_off" {
  description             = "c2cgap-kms013-explicit-off CMK with rotation explicitly disabled"
  deletion_window_in_days = 10
  enable_key_rotation     = false

  tags = {
    Name = "c2cgap-kms013-explicit-off"
    Rule = "KMS-013"
  }
}

resource "aws_kms_key" "kms013_omitted" {
  description             = "c2cgap-kms013-omitted CMK with rotation left at default"
  deletion_window_in_days = 10

  tags = {
    Name = "c2cgap-kms013-omitted"
    Rule = "KMS-013"
  }
}

resource "aws_kms_key" "kms013_on_default_period" {
  description             = "c2cgap-kms013-on-default-period CMK with rotation on, default 365-day period"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = {
    Name = "c2cgap-kms013-on-default-period"
    Rule = "KMS-013"
  }
}

resource "aws_kms_key" "kms013_on_long_period" {
  description             = "c2cgap-kms013-on-long-period CMK with rotation on, 365-day period"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  rotation_period_in_days = 365

  tags = {
    Name = "c2cgap-kms013-on-long-period"
    Rule = "KMS-013"
  }
}

resource "aws_kms_key" "kms013_var_off" {
  description             = "c2cgap-kms013-var-off CMK with rotation driven by variable default false"
  deletion_window_in_days = 10
  enable_key_rotation     = local.kms013_var_off_enable_rotation

  tags = {
    Name = "c2cgap-kms013-var-off"
    Rule = "KMS-013"
  }
}

resource "aws_kms_key" "kms013_with_policy" {
  description             = "c2cgap-kms013-with-policy CMK with separate key policy and alias, rotation omitted"
  deletion_window_in_days = 10

  tags = {
    Name = "c2cgap-kms013-with-policy"
    Rule = "KMS-013"
  }
}

resource "aws_kms_key_policy" "kms013_with_policy_policy" {
  key_id = aws_kms_key.kms013_with_policy.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "EnableRoot"
      Effect    = "Allow"
      Principal = { AWS = "arn:aws:iam::${var.account_id}:root" }
      Action    = "kms:*"
      Resource  = "*"
    }]
  })
}

resource "aws_kms_alias" "kms013_with_policy_alias" {
  name          = "alias/c2cgap-kms013-with-policy"
  target_key_id = aws_kms_key.kms013_with_policy.key_id
}

resource "awscc_kms_key" "kms013cc_explicit_off" {
  description         = "c2cgap-kms013cc-explicit-off awscc CMK with rotation explicitly disabled"
  enable_key_rotation = false
  key_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "EnableRoot"
      Effect    = "Allow"
      Principal = { AWS = "arn:aws:iam::${var.account_id}:root" }
      Action    = "kms:*"
      Resource  = "*"
    }]
  })

  tags = [
    { key = "Name", value = "c2cgap-kms013cc-explicit-off" },
    { key = "Project", value = "wiz-c2c-gap" },
    { key = "Rule", value = "KMS-013" },
  ]
}

resource "awscc_kms_key" "kms013cc_omitted" {
  description = "c2cgap-kms013cc-omitted awscc CMK with rotation left at default"
  key_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "EnableRoot"
      Effect    = "Allow"
      Principal = { AWS = "arn:aws:iam::${var.account_id}:root" }
      Action    = "kms:*"
      Resource  = "*"
    }]
  })

  tags = [
    { key = "Name", value = "c2cgap-kms013cc-omitted" },
    { key = "Project", value = "wiz-c2c-gap" },
    { key = "Rule", value = "KMS-013" },
  ]
}

resource "awscc_kms_key" "kms013cc_on_long_period" {
  description             = "c2cgap-kms013cc-on-long-period awscc CMK with rotation on, 365-day period"
  enable_key_rotation     = true
  rotation_period_in_days = 365
  key_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "EnableRoot"
      Effect    = "Allow"
      Principal = { AWS = "arn:aws:iam::${var.account_id}:root" }
      Action    = "kms:*"
      Resource  = "*"
    }]
  })

  tags = [
    { key = "Name", value = "c2cgap-kms013cc-on-long-period" },
    { key = "Project", value = "wiz-c2c-gap" },
    { key = "Rule", value = "KMS-013" },
  ]
}
