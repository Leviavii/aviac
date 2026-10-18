locals {
  s3_023_enable_replication = false
  s3_023_replication_rules  = var.account_id != "" ? [] : []
  s3_023_foreach_buckets = {
    primary = { replicate = true }
    scratch = { replicate = false }
  }
}

resource "aws_s3_bucket" "s3_023_inline_disabled" {
  bucket     = "c2cgap-s3023-inline-disabled-${var.account_id}"
  depends_on = [aws_s3_bucket_versioning.s3_023_crr_replica_versioning]

  versioning {
    enabled = true
  }

  replication_configuration {
    role = aws_iam_role.s3_023_crr_replica_source_role.arn

    rules {
      id     = "replicate-all"
      status = "Disabled"

      destination {
        bucket        = "arn:aws:s3:::c2cgap-s3023-crr-replica-${var.account_id}"
        storage_class = "STANDARD"
      }
    }
  }

  tags = {
    Rule = "S3-023"
  }
}

resource "aws_s3_bucket" "s3_023_default" {
  bucket = "c2cgap-s3023-default-${var.account_id}"

  tags = {
    Rule = "S3-023"
  }
}

resource "aws_s3_bucket" "s3_023_split_disabled" {
  bucket = "c2cgap-s3023-split-disabled-${var.account_id}"

  tags = {
    Rule = "S3-023"
  }
}

resource "aws_s3_bucket_versioning" "s3_023_split_disabled_versioning" {
  bucket = aws_s3_bucket.s3_023_split_disabled.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "s3_023_split_disabled_replication" {
  depends_on = [aws_s3_bucket_versioning.s3_023_split_disabled_versioning, aws_s3_bucket_versioning.s3_023_crr_replica_versioning]

  role   = aws_iam_role.s3_023_crr_replica_source_role.arn
  bucket = aws_s3_bucket.s3_023_split_disabled.id

  rule {
    id     = "replicate-all"
    status = "Disabled"

    filter {}

    delete_marker_replication {
      status = "Disabled"
    }

    destination {
      bucket        = "arn:aws:s3:::c2cgap-s3023-crr-replica-${var.account_id}"
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket" "s3_023_crr_replica" {
  bucket = "c2cgap-s3023-crr-replica-${var.account_id}"

  tags = {
    Rule = "S3-023"
  }
}

resource "aws_s3_bucket_versioning" "s3_023_crr_replica_versioning" {
  bucket = aws_s3_bucket.s3_023_crr_replica.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "s3_023_crr_replica_source" {
  bucket = "c2cgap-s3023-crr-replica-source-${var.account_id}"

  tags = {
    Rule = "S3-023"
  }
}

resource "aws_iam_role" "s3_023_crr_replica_source_role" {
  name = "c2cgap-s3023-replication"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "s3.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })

  tags = {
    Rule = "S3-023"
  }
}

resource "aws_s3_bucket_versioning" "s3_023_crr_replica_source_versioning" {
  bucket = aws_s3_bucket.s3_023_crr_replica_source.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "s3_023_crr_replica_source_replication" {
  depends_on = [aws_s3_bucket_versioning.s3_023_crr_replica_source_versioning, aws_s3_bucket_versioning.s3_023_crr_replica_versioning]

  role   = aws_iam_role.s3_023_crr_replica_source_role.arn
  bucket = aws_s3_bucket.s3_023_crr_replica_source.id

  rule {
    id     = "replicate-all"
    status = "Enabled"

    filter {}

    delete_marker_replication {
      status = "Disabled"
    }

    destination {
      bucket        = aws_s3_bucket.s3_023_crr_replica.arn
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket" "s3_023_count_toggle" {
  bucket = "c2cgap-s3023-count-toggle-${var.account_id}"

  tags = {
    Rule = "S3-023"
  }
}

resource "aws_s3_bucket_versioning" "s3_023_count_toggle_versioning" {
  bucket = aws_s3_bucket.s3_023_count_toggle.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "s3_023_count_toggle_replication" {
  count      = local.s3_023_enable_replication ? 1 : 0
  depends_on = [aws_s3_bucket_versioning.s3_023_count_toggle_versioning, aws_s3_bucket_versioning.s3_023_crr_replica_versioning]

  role   = aws_iam_role.s3_023_crr_replica_source_role.arn
  bucket = aws_s3_bucket.s3_023_count_toggle.id

  rule {
    id     = "replicate-all"
    status = "Enabled"

    filter {}

    delete_marker_replication {
      status = "Disabled"
    }

    destination {
      bucket        = "arn:aws:s3:::c2cgap-s3023-crr-replica-${var.account_id}"
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket" "s3_023_inline_dynamic" {
  bucket     = "c2cgap-s3023-inline-dynamic-${var.account_id}"
  depends_on = [aws_s3_bucket_versioning.s3_023_crr_replica_versioning]

  versioning {
    enabled = true
  }

  dynamic "replication_configuration" {
    for_each = local.s3_023_enable_replication ? [1] : []
    content {
      role = aws_iam_role.s3_023_crr_replica_source_role.arn

      rules {
        id     = "replicate-all"
        status = "Enabled"

        destination {
          bucket        = "arn:aws:s3:::c2cgap-s3023-crr-replica-${var.account_id}"
          storage_class = "STANDARD"
        }
      }
    }
  }

  tags = {
    Rule = "S3-023"
  }
}

resource "aws_s3_bucket" "s3_023_foreach" {
  for_each = local.s3_023_foreach_buckets
  bucket   = "c2cgap-s3023-foreach-${each.key}-${var.account_id}"

  tags = {
    Rule = "S3-023"
  }
}

resource "aws_s3_bucket_versioning" "s3_023_foreach_versioning" {
  for_each = aws_s3_bucket.s3_023_foreach
  bucket   = each.value.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "s3_023_foreach_replication" {
  for_each   = { for k, v in local.s3_023_foreach_buckets : k => v if v.replicate }
  depends_on = [aws_s3_bucket_versioning.s3_023_foreach_versioning, aws_s3_bucket_versioning.s3_023_crr_replica_versioning]

  role   = aws_iam_role.s3_023_crr_replica_source_role.arn
  bucket = aws_s3_bucket.s3_023_foreach[each.key].id

  rule {
    id     = "replicate-all"
    status = "Enabled"

    filter {}

    delete_marker_replication {
      status = "Disabled"
    }

    destination {
      bucket        = "arn:aws:s3:::c2cgap-s3023-crr-replica-${var.account_id}"
      storage_class = "STANDARD"
    }
  }
}

resource "aws_s3_bucket" "s3_023_module_style" {
  bucket = "c2cgap-s3023-module-style-${var.account_id}"

  tags = {
    Rule = "S3-023"
  }
}

resource "aws_s3_bucket_versioning" "s3_023_module_style_versioning" {
  bucket = aws_s3_bucket.s3_023_module_style.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "s3_023_module_style_replication" {
  count      = length(local.s3_023_replication_rules) > 0 ? 1 : 0
  depends_on = [aws_s3_bucket_versioning.s3_023_module_style_versioning, aws_s3_bucket_versioning.s3_023_crr_replica_versioning]

  role   = aws_iam_role.s3_023_crr_replica_source_role.arn
  bucket = aws_s3_bucket.s3_023_module_style.id

  dynamic "rule" {
    for_each = local.s3_023_replication_rules
    content {
      id     = rule.value.id
      status = rule.value.status

      filter {}

      delete_marker_replication {
        status = "Disabled"
      }

      destination {
        bucket        = "arn:aws:s3:::c2cgap-s3023-crr-replica-${var.account_id}"
        storage_class = "STANDARD"
      }
    }
  }
}

resource "aws_s3_bucket" "s3_023_cond_foreach" {
  bucket = "c2cgap-s3023-cond-foreach-${var.account_id}"

  tags = {
    Rule = "S3-023"
  }
}

resource "aws_s3_bucket_versioning" "s3_023_cond_foreach_versioning" {
  bucket = aws_s3_bucket.s3_023_cond_foreach.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_replication_configuration" "s3_023_cond_foreach_replication" {
  for_each   = local.s3_023_enable_replication ? toset(["enabled"]) : toset([])
  depends_on = [aws_s3_bucket_versioning.s3_023_cond_foreach_versioning, aws_s3_bucket_versioning.s3_023_crr_replica_versioning]

  role   = aws_iam_role.s3_023_crr_replica_source_role.arn
  bucket = aws_s3_bucket.s3_023_cond_foreach.id

  rule {
    id     = "replicate-all"
    status = "Enabled"

    filter {}

    delete_marker_replication {
      status = "Disabled"
    }

    destination {
      bucket        = "arn:aws:s3:::c2cgap-s3023-crr-replica-${var.account_id}"
      storage_class = "STANDARD"
    }
  }
}
