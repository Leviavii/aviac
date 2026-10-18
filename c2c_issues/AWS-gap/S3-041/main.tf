locals {
  object_lock_enabled = false
}

resource "aws_s3_bucket" "s3041_explicit_false" {
  bucket              = "c2cgap-s3041-explicit-false-${var.account_id}"
  object_lock_enabled = false

  tags = {
    Rule = "S3-041"
  }
}

resource "aws_s3_bucket" "s3041_default" {
  bucket = "c2cgap-s3041-default-${var.account_id}"

  tags = {
    Rule = "S3-041"
  }
}

resource "aws_s3_bucket" "s3041_var_false" {
  bucket              = "c2cgap-s3041-var-false-${var.account_id}"
  object_lock_enabled = local.object_lock_enabled

  tags = {
    Rule = "S3-041"
  }
}

resource "aws_s3_bucket" "s3041_cond_lock" {
  bucket              = "c2cgap-s3041-cond-lock-${var.account_id}"
  object_lock_enabled = local.object_lock_enabled

  tags = {
    Rule = "S3-041"
  }
}

resource "aws_s3_bucket_versioning" "s3041_cond_lock" {
  count  = local.object_lock_enabled ? 1 : 0
  bucket = aws_s3_bucket.s3041_cond_lock.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_object_lock_configuration" "s3041_cond_lock" {
  count  = local.object_lock_enabled ? 1 : 0
  bucket = aws_s3_bucket.s3041_cond_lock.id

  rule {
    default_retention {
      mode = "GOVERNANCE"
      days = 30
    }
  }
}

resource "aws_s3_bucket" "s3041_count_bucket" {
  count               = 1
  bucket              = "c2cgap-s3041-count-bucket-${var.account_id}"
  object_lock_enabled = local.object_lock_enabled

  tags = {
    Rule = "S3-041"
  }
}

resource "aws_s3_bucket_object_lock_configuration" "s3041_count_bucket" {
  count  = local.object_lock_enabled ? 1 : 0
  bucket = aws_s3_bucket.s3041_count_bucket[0].id

  rule {
    default_retention {
      mode = "GOVERNANCE"
      days = 30
    }
  }
}

locals {
  s3041_buckets = {
    archive = {
      object_lock = false
    }
  }
}

resource "aws_s3_bucket" "s3041_foreach" {
  for_each            = local.s3041_buckets
  bucket              = "c2cgap-s3041-foreach-${each.key}-${var.account_id}"
  object_lock_enabled = each.value.object_lock

  tags = {
    Rule = "S3-041"
  }
}

resource "aws_s3_bucket_versioning" "s3041_foreach" {
  for_each = { for k, v in local.s3041_buckets : k => v if v.object_lock }
  bucket   = aws_s3_bucket.s3041_foreach[each.key].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_object_lock_configuration" "s3041_foreach" {
  for_each = { for k, v in local.s3041_buckets : k => v if v.object_lock }
  bucket   = aws_s3_bucket.s3041_foreach[each.key].id

  rule {
    default_retention {
      mode = "GOVERNANCE"
      days = 30
    }
  }
}

resource "aws_s3_bucket" "s3041_each_nolock" {
  for_each            = local.s3041_buckets
  bucket              = "c2cgap-s3041-nolock-${each.key}-${var.account_id}"
  object_lock_enabled = each.value.object_lock

  tags = {
    Rule = "S3-041"
  }
}

locals {
  s3041_tfmod_create_bucket             = true
  s3041_tfmod_object_lock_enabled       = false
  s3041_tfmod_object_lock_configuration = jsondecode(var.account_id == "" ? "{}" : "{}")
}

resource "aws_s3_bucket" "s3041_tfmod" {
  count = local.s3041_tfmod_create_bucket ? 1 : 0

  bucket              = "c2cgap-s3041-tfmod-${var.account_id}"
  force_destroy       = false
  object_lock_enabled = local.s3041_tfmod_object_lock_enabled

  tags = {
    Rule = "S3-041"
  }
}

resource "aws_s3_bucket_object_lock_configuration" "s3041_tfmod" {
  count = local.s3041_tfmod_create_bucket && local.s3041_tfmod_object_lock_enabled && try(local.s3041_tfmod_object_lock_configuration.rule.default_retention, null) != null ? 1 : 0

  bucket = aws_s3_bucket.s3041_tfmod[0].id
  token  = try(local.s3041_tfmod_object_lock_configuration.token, null)

  rule {
    default_retention {
      mode  = local.s3041_tfmod_object_lock_configuration.rule.default_retention.mode
      days  = try(local.s3041_tfmod_object_lock_configuration.rule.default_retention.days, null)
      years = try(local.s3041_tfmod_object_lock_configuration.rule.default_retention.years, null)
    }
  }
}
