resource "aws_s3_bucket" "s3_013_inline" {
  bucket = "c2cgap-s3013-inline-${var.account_id}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontRead"
        Effect    = "Allow"
        Principal = { Service = "cloudfront.amazonaws.com" }
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::c2cgap-s3013-inline-306026247677/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::306026247677:distribution/EDFDVBD6EXAMPLE"
          }
        }
      }
    ]
  })

  tags = {
    Rule = "S3-013"
  }
}

resource "aws_s3_bucket" "s3_013_nopolicy" {
  bucket = "c2cgap-s3013-nopolicy-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

resource "aws_s3_bucket" "s3_013_jsonenc" {
  bucket = "c2cgap-s3013-jsonenc-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

resource "aws_s3_bucket_policy" "s3_013_jsonenc_policy" {
  bucket = aws_s3_bucket.s3_013_jsonenc.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontRead"
        Effect    = "Allow"
        Principal = { Service = "cloudfront.amazonaws.com" }
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.s3_013_jsonenc.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "arn:aws:cloudfront::306026247677:distribution/EDFDVBD6EXAMPLE"
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket" "s3_013_heredoc" {
  bucket = "c2cgap-s3013-heredoc-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

resource "aws_s3_bucket_policy" "s3_013_heredoc_policy" {
  bucket = aws_s3_bucket.s3_013_heredoc.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowCloudFrontRead",
      "Effect": "Allow",
      "Principal": { "Service": "cloudfront.amazonaws.com" },
      "Action": "s3:GetObject",
      "Resource": "${aws_s3_bucket.s3_013_heredoc.arn}/*",
      "Condition": {
        "StringEquals": {
          "AWS:SourceArn": "arn:aws:cloudfront::306026247677:distribution/EDFDVBD6EXAMPLE"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "s3_013_datadoc" {
  bucket = "c2cgap-s3013-datadoc-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

data "aws_iam_policy_document" "s3_013_datadoc_doc" {
  statement {
    sid       = "AllowCloudFrontRead"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_013_datadoc.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = ["arn:aws:cloudfront::306026247677:distribution/EDFDVBD6EXAMPLE"]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_013_datadoc_policy" {
  bucket = aws_s3_bucket.s3_013_datadoc.id
  policy = data.aws_iam_policy_document.s3_013_datadoc_doc.json
}

locals {
  s3_013_local_policy_json = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontRead"
        Effect    = "Allow"
        Principal = { Service = "cloudfront.amazonaws.com" }
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::c2cgap-s3013-local-306026247677/*"
      }
    ]
  })
  s3_013_dyn_readers = ["arn:aws:iam::306026247677:root"]
}

resource "aws_s3_bucket" "s3_013_local" {
  bucket = "c2cgap-s3013-local-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

resource "aws_s3_bucket_policy" "s3_013_local_policy" {
  bucket = aws_s3_bucket.s3_013_local.id
  policy = local.s3_013_local_policy_json
}

resource "aws_s3_bucket" "s3_013_file" {
  bucket = "c2cgap-s3013-file-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

resource "aws_s3_bucket_policy" "s3_013_file_policy" {
  bucket = aws_s3_bucket.s3_013_file.id
  policy = templatefile("${path.module}/s3_013_file_policy.json.tpl", {
    bucket_arn = aws_s3_bucket.s3_013_file.arn
  })
}

resource "aws_s3_bucket" "s3_013_staticfile" {
  bucket = "c2cgap-s3013-staticfile-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

resource "aws_s3_bucket_policy" "s3_013_staticfile_policy" {
  bucket = aws_s3_bucket.s3_013_staticfile.id
  policy = file("${path.module}/s3_013_staticfile_policy.json")
}

resource "aws_s3_bucket" "s3_013_count" {
  count  = 1
  bucket = "c2cgap-s3013-count-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

resource "aws_s3_bucket_policy" "s3_013_count_policy" {
  count  = 1
  bucket = aws_s3_bucket.s3_013_count[0].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "cloudfront.amazonaws.com" }
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.s3_013_count[0].arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket" "s3_013_dyn" {
  bucket = "c2cgap-s3013-dyn-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

data "aws_iam_policy_document" "s3_013_dyn_doc" {
  dynamic "statement" {
    for_each = local.s3_013_dyn_readers
    content {
      effect    = "Allow"
      actions   = ["s3:GetObject"]
      resources = ["${aws_s3_bucket.s3_013_dyn.arn}/*"]
      principals {
        type        = "AWS"
        identifiers = [statement.value]
      }
    }
  }
}

resource "aws_s3_bucket_policy" "s3_013_dyn_policy" {
  bucket = aws_s3_bucket.s3_013_dyn.id
  policy = data.aws_iam_policy_document.s3_013_dyn_doc.json
}

resource "aws_s3_bucket" "s3_013_src" {
  bucket = "c2cgap-s3013-src-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

data "aws_iam_policy_document" "s3_013_src_base" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_013_src.arn}/*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::306026247677:root"]
    }
  }
}

data "aws_iam_policy_document" "s3_013_src_combined" {
  source_policy_documents = [data.aws_iam_policy_document.s3_013_src_base.json]
}

resource "aws_s3_bucket_policy" "s3_013_src_policy" {
  bucket = aws_s3_bucket.s3_013_src.id
  policy = data.aws_iam_policy_document.s3_013_src_combined.json
}

resource "aws_s3_bucket" "s3_013_ifexists" {
  bucket = "c2cgap-s3013-ifexists-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

data "aws_iam_policy_document" "s3_013_ifexists_doc" {
  statement {
    sid       = "DenyInsecureTransport"
    effect    = "Deny"
    actions   = ["s3:*"]
    resources = [aws_s3_bucket.s3_013_ifexists.arn, "${aws_s3_bucket.s3_013_ifexists.arn}/*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "BoolIfExists"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_013_ifexists_policy" {
  bucket = aws_s3_bucket.s3_013_ifexists.id
  policy = data.aws_iam_policy_document.s3_013_ifexists_doc.json
}

resource "aws_s3_bucket" "s3_013_cntlit" {
  count  = 1
  bucket = "c2cgap-s3013-cntlit-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

resource "aws_s3_bucket_policy" "s3_013_cntlit_policy" {
  count  = 1
  bucket = aws_s3_bucket.s3_013_cntlit[0].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "cloudfront.amazonaws.com" }
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::c2cgap-s3013-cntlit-306026247677/*"
      }
    ]
  })
}

resource "aws_s3_bucket" "s3_013_cntdoc" {
  count  = 1
  bucket = "c2cgap-s3013-cntdoc-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

data "aws_iam_policy_document" "s3_013_cntdoc_doc" {
  count = 1
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.s3_013_cntdoc[0].arn}/*"]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
  }
}

resource "aws_s3_bucket_policy" "s3_013_cntdoc_policy" {
  count  = 1
  bucket = aws_s3_bucket.s3_013_cntdoc[0].id
  policy = data.aws_iam_policy_document.s3_013_cntdoc_doc[0].json
}

resource "aws_s3_bucket" "s3_013_fe" {
  for_each = toset(["logs"])
  bucket   = "c2cgap-s3013-fe-${each.key}-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

resource "aws_s3_bucket_policy" "s3_013_fe_policy" {
  for_each = aws_s3_bucket.s3_013_fe
  bucket   = each.value.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "cloudfront.amazonaws.com" }
        Action    = "s3:GetObject"
        Resource  = "${each.value.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket" "s3_013_litname" {
  bucket = "c2cgap-s3013-litname-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

resource "aws_s3_bucket_policy" "s3_013_litname_policy" {
  bucket = "c2cgap-s3013-litname-${var.account_id}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "cloudfront.amazonaws.com" }
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::c2cgap-s3013-litname-306026247677/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket.s3_013_litname]
}

resource "aws_s3_bucket" "s3_013_partial" {
  bucket = "c2cgap-s3013-partial-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

resource "aws_s3_bucket_policy" "s3_013_partial_policy" {
  bucket = aws_s3_bucket.s3_013_partial.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyInsecurePuts"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:PutObject"
        Resource  = "arn:aws:s3:::c2cgap-s3013-partial-306026247677/*"
        Condition = {
          Bool = { "aws:SecureTransport" = "false" }
        }
      }
    ]
  })
}

resource "aws_s3_bucket" "s3_013_selfref" {
  bucket = "c2cgap-s3013-selfref-${var.account_id}"

  tags = {
    Rule = "S3-013"
  }
}

resource "aws_s3_bucket_policy" "s3_013_selfref_policy" {
  bucket = aws_s3_bucket.s3_013_selfref.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontRead"
        Effect    = "Allow"
        Principal = { Service = "cloudfront.amazonaws.com" }
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.s3_013_selfref.arn}/*"
      }
    ]
  })
}
