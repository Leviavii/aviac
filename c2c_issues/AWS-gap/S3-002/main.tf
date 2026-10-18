locals {
  s3002_versioning_enabled = false
  s3002_create_versioning  = false
}

resource "aws_s3_bucket" "s3002_inline_disabled" {
  bucket = "c2cgap-s3002-inline-disabled-${var.account_id}"

  versioning {
    enabled = false
  }

  tags = {
    Rule = "S3-002"
  }
}

resource "aws_s3_bucket" "s3002_omitted" {
  bucket = "c2cgap-s3002-omitted-${var.account_id}"

  tags = {
    Rule = "S3-002"
  }
}

resource "aws_s3_bucket" "s3002_split_suspended" {
  bucket = "c2cgap-s3002-split-suspended-${var.account_id}"

  tags = {
    Rule = "S3-002"
  }
}

resource "aws_s3_bucket_versioning" "s3002_split_suspended_versioning" {
  bucket = aws_s3_bucket.s3002_split_suspended.id

  versioning_configuration {
    status = "Suspended"
  }
}

resource "aws_s3_bucket" "s3002_var_status" {
  bucket = "c2cgap-s3002-var-status-${var.account_id}"

  tags = {
    Rule = "S3-002"
  }
}

resource "aws_s3_bucket_versioning" "s3002_var_status_versioning" {
  bucket = aws_s3_bucket.s3002_var_status.id

  versioning_configuration {
    status = local.s3002_versioning_enabled ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket" "s3002_count_off" {
  bucket = "c2cgap-s3002-count-off-${var.account_id}"

  tags = {
    Rule = "S3-002"
  }
}

resource "aws_s3_bucket_versioning" "s3002_count_off_versioning" {
  count  = local.s3002_create_versioning ? 1 : 0
  bucket = aws_s3_bucket.s3002_count_off.id

  versioning_configuration {
    status = "Enabled"
  }
}

locals {
  s3002_foreach_buckets = {
    logs = false
    data = true
  }
}

resource "aws_s3_bucket" "s3002_foreach_filtered" {
  for_each = local.s3002_foreach_buckets
  bucket   = "c2cgap-s3002-foreach-${each.key}-${var.account_id}"

  tags = {
    Rule = "S3-002"
  }
}

resource "aws_s3_bucket_versioning" "s3002_foreach_filtered_versioning" {
  for_each = { for k, v in local.s3002_foreach_buckets : k => v if v }
  bucket   = aws_s3_bucket.s3002_foreach_filtered[each.key].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "s3002_count_index" {
  count  = 2
  bucket = "c2cgap-s3002-count-index-${count.index}-${var.account_id}"

  tags = {
    Rule = "S3-002"
  }
}

resource "aws_s3_bucket_versioning" "s3002_count_index_versioning" {
  bucket = aws_s3_bucket.s3002_count_index[0].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "s3002_split_disabled" {
  bucket = "c2cgap-s3002-split-disabled-${var.account_id}"

  tags = {
    Rule = "S3-002"
  }
}

resource "aws_s3_bucket_versioning" "s3002_split_disabled_versioning" {
  bucket = aws_s3_bucket.s3002_split_disabled.id

  versioning_configuration {
    status = "Disabled"
  }
}
