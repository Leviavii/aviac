###############################################################################
# S3-019: S3 bucket policy should not allow s3:PutObject for all principals
# without conditions
# Misconfiguration: bucket policy with Principal=* and Action=s3:PutObject
# with no Condition, Effect=Allow
###############################################################################

resource "aws_s3_bucket" "wiz_s3_019" {
  bucket = "wiz-s3-019-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_s3_bucket_public_access_block" "wiz_s3_019" {
  bucket = aws_s3_bucket.wiz_s3_019.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "wiz_s3_019" {
  depends_on = [aws_s3_bucket_public_access_block.wiz_s3_019]
  bucket     = aws_s3_bucket.wiz_s3_019.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "MYBUCKETPOLICY"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:PutObject"
        Resource  = "arn:aws:s3:::wiz-s3-019-306026247677/*"
      }
    ]
  })
}
