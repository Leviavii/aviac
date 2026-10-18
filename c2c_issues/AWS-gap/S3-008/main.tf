locals {
  s3_008_d2_lc_count0_enable_lifecycle        = false
  s3_008_d4_dynamic_lc_empty_enable_lifecycle = false
  s3_008_d5_create_bucket                     = true
  s3_008_d5_lifecycle_rules                   = []
}

resource "aws_s3_bucket" "s3_008_a_inline" {
  bucket = "c2cgap-s3-008-a-inline-${var.account_id}"

  versioning {
    enabled    = true
    mfa_delete = false
  }

  tags = {
    Rule = "S3-008"
  }
}

resource "aws_s3_bucket" "s3_008_b_default" {
  bucket = "c2cgap-s3-008-b-default-${var.account_id}"

  tags = {
    Rule = "S3-008"
  }
}

resource "aws_s3_bucket" "s3_008_c1_ver_disabled" {
  bucket = "c2cgap-s3-008-c1-ver-disabled-${var.account_id}"

  tags = {
    Rule = "S3-008"
  }
}

resource "aws_s3_bucket_versioning" "s3_008_c1_ver_disabled_versioning" {
  bucket = aws_s3_bucket.s3_008_c1_ver_disabled.id

  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }
}

resource "aws_s3_bucket" "s3_008_c2_ver_omitted" {
  bucket = "c2cgap-s3-008-c2-ver-omitted-${var.account_id}"

  tags = {
    Rule = "S3-008"
  }
}

resource "aws_s3_bucket_versioning" "s3_008_c2_ver_omitted_versioning" {
  bucket = aws_s3_bucket.s3_008_c2_ver_omitted.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "s3_008_d1_lc_disabled" {
  bucket = "c2cgap-s3-008-d1-lc-disabled-${var.account_id}"

  tags = {
    Rule = "S3-008"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_008_d1_lc_disabled_lifecycle" {
  bucket = aws_s3_bucket.s3_008_d1_lc_disabled.id

  rule {
    id     = "expire-old"
    status = "Disabled"

    filter {}

    expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket" "s3_008_d2_lc_count0" {
  bucket = "c2cgap-s3-008-d2-lc-count0-${var.account_id}"

  tags = {
    Rule = "S3-008"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_008_d2_lc_count0_lifecycle" {
  count  = local.s3_008_d2_lc_count0_enable_lifecycle ? 1 : 0
  bucket = aws_s3_bucket.s3_008_d2_lc_count0.id

  rule {
    id     = "expire-old"
    status = "Enabled"

    filter {}

    expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket" "s3_008_d3_inline_lc_disabled" {
  bucket = "c2cgap-s3-008-d3-inline-lc-disabled-${var.account_id}"

  lifecycle_rule {
    id      = "expire-old"
    enabled = false

    expiration {
      days = 90
    }
  }

  tags = {
    Rule = "S3-008"
  }
}

resource "aws_s3_bucket" "s3_008_d4_dynamic_lc_empty" {
  bucket = "c2cgap-s3-008-d4-dynamic-lc-empty-${var.account_id}"

  dynamic "lifecycle_rule" {
    for_each = local.s3_008_d4_dynamic_lc_empty_enable_lifecycle ? [1] : []
    content {
      id      = "expire-old"
      enabled = true

      expiration {
        days = 90
      }
    }
  }

  tags = {
    Rule = "S3-008"
  }
}

resource "aws_s3_bucket" "s3_008_a2_inline_mfa_omitted" {
  bucket = "c2cgap-s3-008-a2-inline-mfa-omitted-${var.account_id}"

  versioning {
    enabled = true
  }

  tags = {
    Rule = "S3-008"
  }
}

resource "aws_s3_bucket" "s3_008_d5_module_pattern" {
  count  = local.s3_008_d5_create_bucket ? 1 : 0
  bucket = "c2cgap-s3-008-d5-module-pattern-${var.account_id}"

  tags = {
    Rule = "S3-008"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_008_d5_module_pattern_lifecycle" {
  count  = local.s3_008_d5_create_bucket && length(local.s3_008_d5_lifecycle_rules) > 0 ? 1 : 0
  bucket = aws_s3_bucket.s3_008_d5_module_pattern[0].id

  dynamic "rule" {
    for_each = local.s3_008_d5_lifecycle_rules
    content {
      id     = try(rule.value.id, null)
      status = try(rule.value.enabled ? "Enabled" : "Disabled", "Enabled")

      filter {}

      expiration {
        days = try(rule.value.expiration.days, null)
      }
    }
  }
}

resource "aws_s3_bucket" "s3_008_e_count_bucket" {
  count  = local.s3_008_d5_create_bucket ? 1 : 0
  bucket = "c2cgap-s3-008-e-count-bucket-${var.account_id}"

  tags = {
    Rule = "S3-008"
  }
}
