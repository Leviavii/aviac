locals {
  enable_access_logging  = false
  log_bucket_name        = "c2cgap-s3001-central-access-logs-${var.account_id}"
  create_bucket          = true
  logging                = jsondecode(var.account_id == "" ? "{}" : "{}")
  access_logging         = jsondecode(var.account_id == "" ? "[]" : "[]")
  s3_001_cpmod_bucket_id = join("", aws_s3_bucket.s3_001_cpmod[*].id)
}

resource "aws_s3_bucket" "s3_001_default" {
  bucket = "c2cgap-s3001-default-${var.account_id}"

  tags = {
    Rule = "S3-001"
  }
}

resource "aws_s3_bucket" "s3_001_dynoff" {
  bucket = "c2cgap-s3001-dynoff-${var.account_id}"

  dynamic "logging" {
    for_each = local.enable_access_logging ? [1] : []
    content {
      target_bucket = local.log_bucket_name
      target_prefix = "s3-001-dynoff/"
    }
  }

  tags = {
    Rule = "S3-001"
  }
}

resource "aws_s3_bucket" "s3_001_condlog" {
  bucket = "c2cgap-s3001-condlog-${var.account_id}"

  tags = {
    Rule = "S3-001"
  }
}

resource "aws_s3_bucket_logging" "s3_001_condlog_logging" {
  count         = local.enable_access_logging ? 1 : 0
  bucket        = aws_s3_bucket.s3_001_condlog.id
  target_bucket = local.log_bucket_name
  target_prefix = "s3-001-condlog/"
}

resource "aws_s3_bucket" "s3_001_foreach" {
  for_each = toset(["raw", "curated"])
  bucket   = "c2cgap-s3001-foreach-${each.key}-${var.account_id}"

  tags = {
    Rule = "S3-001"
  }
}

resource "aws_s3_bucket" "s3_001_tfam" {
  count = local.create_bucket ? 1 : 0

  bucket        = "c2cgap-s3001-tfam-${var.account_id}"
  force_destroy = false

  tags = {
    Rule = "S3-001"
  }
}

resource "aws_s3_bucket_logging" "s3_001_tfam_logging" {
  count = local.create_bucket && length(keys(local.logging)) > 0 ? 1 : 0

  bucket = aws_s3_bucket.s3_001_tfam[0].id

  target_bucket = local.logging["target_bucket"]
  target_prefix = try(local.logging["target_prefix"], null)
}

resource "aws_s3_bucket" "s3_001_cpmod" {
  count         = local.create_bucket ? 1 : 0
  bucket        = "c2cgap-s3001-cpmod-${var.account_id}"
  force_destroy = false

  tags = {
    Rule = "S3-001"
  }
}

resource "aws_s3_bucket_logging" "s3_001_cpmod_logging" {
  for_each = toset(local.create_bucket && length(local.access_logging) > 0 ? ["enabled"] : [])

  bucket = local.s3_001_cpmod_bucket_id

  target_bucket = local.access_logging[0]["bucket_name"]
  target_prefix = local.access_logging[0]["prefix"]
}
