locals {
  enable_lifecycle = false
}

resource "aws_s3_bucket" "s3_042_default" {
  bucket = "c2cgap-s3042-default-${var.account_id}"

  tags = {
    Rule = "S3-042"
  }
}

resource "aws_s3_bucket" "s3_042_hardened" {
  bucket = "c2cgap-s3042-hardened-${var.account_id}"

  tags = {
    Environment = "prod"
    Rule        = "S3-042"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "s3_042_hardened_versioning" {
  bucket = aws_s3_bucket.s3_042_hardened.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_042_hardened_sse" {
  bucket = aws_s3_bucket.s3_042_hardened.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "s3_042_hardened_pab" {
  bucket                  = aws_s3_bucket.s3_042_hardened.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "s3_042_conditional" {
  bucket = "c2cgap-s3042-conditional-${var.account_id}"

  tags = {
    Rule = "S3-042"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_042_conditional_lifecycle" {
  count  = local.enable_lifecycle ? 1 : 0
  bucket = aws_s3_bucket.s3_042_conditional.id

  rule {
    id     = "expire-old-objects"
    status = "Enabled"

    filter {}

    expiration {
      days = 90
    }
  }
}

resource "aws_s3_bucket" "s3_042_foreach" {
  for_each = toset(["logs", "data"])
  bucket   = "c2cgap-s3042-${each.key}-${var.account_id}"

  tags = {
    Rule = "S3-042"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_042_foreach_lifecycle" {
  bucket = aws_s3_bucket.s3_042_foreach["logs"].id

  rule {
    id     = "expire-logs"
    status = "Enabled"

    filter {}

    expiration {
      days = 30
    }
  }
}

locals {
  lifecycle_rules = []
}

resource "aws_s3_bucket" "s3_042_modstyle" {
  bucket = "c2cgap-s3042-modstyle-${var.account_id}"

  tags = {
    Rule = "S3-042"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_042_modstyle_lifecycle" {
  count  = length(local.lifecycle_rules) > 0 ? 1 : 0
  bucket = aws_s3_bucket.s3_042_modstyle.id

  dynamic "rule" {
    for_each = local.lifecycle_rules

    content {
      id     = rule.value.id
      status = try(rule.value.enabled, true) ? "Enabled" : "Disabled"

      filter {}

      expiration {
        days = rule.value.expiration_days
      }
    }
  }
}
