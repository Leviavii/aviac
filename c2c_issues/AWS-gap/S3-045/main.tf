resource "aws_s3_bucket" "s3045_inline" {
  bucket = "c2cgap-s3045-inline-${var.account_id}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CrossAccountWrite"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::033677994240:root"
        }
        Action   = ["s3:GetObject", "s3:PutObject"]
        Resource = "arn:aws:s3:::c2cgap-s3045-inline-${var.account_id}/*"
      }
    ]
  })

  tags = {
    Rule = "S3-045"
  }
}

resource "aws_s3_bucket" "s3045_jsonenc" {
  bucket = "c2cgap-s3045-jsonenc-${var.account_id}"

  tags = {
    Rule = "S3-045"
  }
}

resource "aws_s3_bucket_policy" "s3045_jsonenc_policy" {
  bucket = aws_s3_bucket.s3045_jsonenc.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CrossAccountWrite"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::033677994240:root"
        }
        Action   = ["s3:PutObject", "s3:GetObject"]
        Resource = "${aws_s3_bucket.s3045_jsonenc.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket" "s3045_heredoc" {
  bucket = "c2cgap-s3045-heredoc-${var.account_id}"

  tags = {
    Rule = "S3-045"
  }
}

resource "aws_s3_bucket_public_access_block" "s3045_heredoc_pab" {
  bucket                  = aws_s3_bucket.s3045_heredoc.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "s3045_heredoc_policy" {
  bucket     = aws_s3_bucket.s3045_heredoc.id
  depends_on = [aws_s3_bucket_public_access_block.s3045_heredoc_pab]
  policy     = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::c2cgap-s3045-heredoc-${var.account_id}/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "s3045_doccross" {
  bucket = "c2cgap-s3045-doccross-${var.account_id}"

  tags = {
    Rule = "S3-045"
  }
}

data "aws_iam_policy_document" "s3045_doccross_doc" {
  statement {
    sid    = "CrossAccountWrite"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::033677994240:root"]
    }
    actions   = ["s3:PutObject", "s3:GetObject"]
    resources = ["${aws_s3_bucket.s3045_doccross.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "s3045_doccross_policy" {
  bucket = aws_s3_bucket.s3045_doccross.id
  policy = data.aws_iam_policy_document.s3045_doccross_doc.json
}

resource "aws_s3_bucket" "s3045_docnoeffect" {
  bucket = "c2cgap-s3045-docnoeffect-${var.account_id}"

  tags = {
    Rule = "S3-045"
  }
}

data "aws_iam_policy_document" "s3045_docnoeffect_doc" {
  statement {
    sid = "CrossAccountWrite"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::033677994240:root"]
    }
    actions   = ["s3:PutObject", "s3:GetObject"]
    resources = ["${aws_s3_bucket.s3045_docnoeffect.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "s3045_docnoeffect_policy" {
  bucket = aws_s3_bucket.s3045_docnoeffect.id
  policy = data.aws_iam_policy_document.s3045_docnoeffect_doc.json
}

resource "aws_s3_bucket" "s3045_docvar" {
  bucket = "c2cgap-s3045-docvar-${var.account_id}"

  tags = {
    Rule = "S3-045"
  }
}

data "aws_iam_policy_document" "s3045_docvar_doc" {
  statement {
    sid    = "CrossAccountWrite"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::033677994240:root"]
    }
    actions   = ["s3:PutObject", "s3:GetObject"]
    resources = ["${aws_s3_bucket.s3045_docvar.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "s3045_docvar_policy" {
  bucket = aws_s3_bucket.s3045_docvar.id
  policy = data.aws_iam_policy_document.s3045_docvar_doc.json
}

resource "aws_s3_bucket" "s3045_bareacct" {
  bucket = "c2cgap-s3045-bareacct-${var.account_id}"

  tags = {
    Rule = "S3-045"
  }
}

resource "aws_s3_bucket_policy" "s3045_bareacct_policy" {
  bucket = aws_s3_bucket.s3045_bareacct.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CrossAccountDelete"
        Effect = "Allow"
        Principal = {
          AWS = "033677994240"
        }
        Action   = "s3:DeleteObject"
        Resource = "arn:aws:s3:::c2cgap-s3045-bareacct-${var.account_id}/*"
      }
    ]
  })
}

resource "aws_s3_bucket" "s3045_awsstar" {
  bucket = "c2cgap-s3045-awsstar-${var.account_id}"

  tags = {
    Rule = "S3-045"
  }
}

resource "aws_s3_bucket_public_access_block" "s3045_awsstar_pab" {
  bucket                  = aws_s3_bucket.s3045_awsstar.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "s3045_awsstar_policy" {
  bucket     = aws_s3_bucket.s3045_awsstar.bucket
  depends_on = [aws_s3_bucket_public_access_block.s3045_awsstar_pab]
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AnyoneFullAccess"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action = "s3:*"
        Resource = [
          "arn:aws:s3:::c2cgap-s3045-awsstar-${var.account_id}",
          "arn:aws:s3:::c2cgap-s3045-awsstar-${var.account_id}/*",
        ]
      }
    ]
  })
}

resource "aws_s3_bucket" "s3045_jsonvar" {
  bucket = "c2cgap-s3045-jsonvar-${var.account_id}"

  tags = {
    Rule = "S3-045"
  }
}

resource "aws_s3_bucket_policy" "s3045_jsonvar_policy" {
  bucket = aws_s3_bucket.s3045_jsonvar.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "PartnerWrite"
        Effect = "Allow"
        Principal = {
          AWS = ["arn:aws:iam::033677994240:root"]
        }
        Action   = ["s3:PutObject", "s3:PutObjectAcl"]
        Resource = "arn:aws:s3:::c2cgap-s3045-jsonvar-${var.account_id}/*"
      }
    ]
  })
}

resource "aws_s3_bucket" "s3045_secondref" {
  bucket = "c2cgap-s3045-secondref-${var.account_id}"

  tags = {
    Rule = "S3-045"
  }
}

resource "aws_s3_bucket_policy" "s3045_secondref_policy" {
  bucket = aws_s3_bucket.s3045_secondref.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CrossAccountRead"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::033677994240:root"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.s3045_secondref.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket" "s3045_namelit" {
  bucket = "c2cgap-s3045-namelit-${var.account_id}"

  tags = {
    Rule = "S3-045"
  }
}

resource "aws_s3_bucket_policy" "s3045_namelit_policy" {
  bucket     = "c2cgap-s3045-namelit-${var.account_id}"
  depends_on = [aws_s3_bucket.s3045_namelit]
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CrossAccountRead"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::033677994240:root"
        }
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::c2cgap-s3045-namelit-${var.account_id}/*"
      }
    ]
  })
}
