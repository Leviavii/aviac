locals {
  s3010_sse_config = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
  s3010_kms_key_empty    = ""
  s3010_cmklocal_key_arn = false ? aws_kms_key.s3010_cmklocal_key[0].arn : null
}

resource "aws_s3_bucket" "s3010_inline_aes" {
  bucket = "c2cgap-s3010-inline-aes-${var.account_id}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Rule = "S3-010"
  }
}

resource "aws_s3_bucket" "s3010_inline_kms" {
  bucket = "c2cgap-s3010-inline-kms-${var.account_id}"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  tags = {
    Rule = "S3-010"
  }
}

resource "aws_s3_bucket" "s3010_defaultenc" {
  bucket = "c2cgap-s3010-defaultenc-${var.account_id}"

  tags = {
    Rule = "S3-010"
  }
}

resource "aws_s3_bucket" "s3010_split_aes" {
  bucket = "c2cgap-s3010-split-aes-${var.account_id}"

  tags = {
    Rule = "S3-010"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3010_split_aes_sse" {
  bucket = aws_s3_bucket.s3010_split_aes.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket" "s3010_split_kms" {
  bucket = "c2cgap-s3010-split-kms-${var.account_id}"

  tags = {
    Rule = "S3-010"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3010_split_kms_sse" {
  bucket = aws_s3_bucket.s3010_split_kms.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket" "s3010_var_key" {
  bucket = "c2cgap-s3010-var-key-${var.account_id}"

  tags = {
    Rule = "S3-010"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3010_var_key_sse" {
  bucket = aws_s3_bucket.s3010_var_key.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = local.s3010_kms_key_arn
    }
  }
}

resource "aws_s3_bucket" "s3010_dyn" {
  bucket = "c2cgap-s3010-dyn-${var.account_id}"

  tags = {
    Rule = "S3-010"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3010_dyn_sse" {
  bucket = aws_s3_bucket.s3010_dyn.id

  dynamic "rule" {
    for_each = [local.s3010_sse_config.rule]
    content {
      bucket_key_enabled = try(rule.value.bucket_key_enabled, null)
      dynamic "apply_server_side_encryption_by_default" {
        for_each = [rule.value.apply_server_side_encryption_by_default]
        content {
          sse_algorithm     = apply_server_side_encryption_by_default.value.sse_algorithm
          kms_master_key_id = try(apply_server_side_encryption_by_default.value.kms_master_key_id, null)
        }
      }
    }
  }
}

resource "aws_s3_bucket" "s3010_emptyvar" {
  bucket = "c2cgap-s3010-emptyvar-${var.account_id}"

  tags = {
    Rule = "S3-010"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3010_emptyvar_sse" {
  bucket = aws_s3_bucket.s3010_emptyvar.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = local.s3010_kms_key_empty
    }
  }
}

resource "aws_s3_bucket" "s3010_condkey" {
  bucket = "c2cgap-s3010-condkey-${var.account_id}"

  tags = {
    Rule = "S3-010"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3010_condkey_sse" {
  bucket = aws_s3_bucket.s3010_condkey.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = local.s3010_kms_key_arn == null ? "AES256" : "aws:kms"
      kms_master_key_id = local.s3010_kms_key_arn
    }
  }
}

resource "aws_kms_key" "s3010_cmklocal_key" {
  count               = false ? 1 : 0
  enable_key_rotation = true

  tags = {
    Rule = "S3-010"
  }
}

resource "aws_s3_bucket" "s3010_cmklocal" {
  bucket = "c2cgap-s3010-cmklocal-${var.account_id}"

  tags = {
    Rule = "S3-010"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3010_cmklocal_sse" {
  bucket = aws_s3_bucket.s3010_cmklocal.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = local.s3010_cmklocal_key_arn
    }
  }
}
