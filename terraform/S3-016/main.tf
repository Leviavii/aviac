###############################################################################
# S3-016: S3 bucket policy should not allow s3:Delete actions for all
# principals without conditions
# Misconfiguration: bucket policy with Principal=* and Action=S3:DeleteObject
# with no Condition, Effect=Allow
###############################################################################

resource "aws_s3_bucket" "wiz_s3_016" {
  bucket = "wiz-s3-016-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_s3_bucket_public_access_block" "wiz_s3_016" {
  bucket = aws_s3_bucket.wiz_s3_016.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "wiz_s3_016" {
  depends_on = [aws_s3_bucket_public_access_block.wiz_s3_016]
  bucket     = aws_s3_bucket.wiz_s3_016.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Allow"
        Principal = "*"
        Action    = "S3:DeleteObject"
        Resource  = "arn:aws:s3:::wiz-s3-016-306026247677/*"
      }
    ]
  })
}
