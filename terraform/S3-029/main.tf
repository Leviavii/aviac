###############################################################################
# S3-029: S3 bucket policy should not allow all actions (s3:*) for all
# principals without conditions
# Misconfiguration: bucket policy with Principal=* and Action=s3:*
# with no Condition, Effect=Allow
###############################################################################

resource "aws_s3_bucket" "wiz_s3_029" {
  bucket = "wiz-s3-029-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_s3_bucket_public_access_block" "wiz_s3_029" {
  bucket = aws_s3_bucket.wiz_s3_029.id

  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "wiz_s3_029" {
  depends_on = [aws_s3_bucket_public_access_block.wiz_s3_029]
  bucket     = aws_s3_bucket.wiz_s3_029.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "id113"
    Statement = [
      {
        Action    = ["s3:*"]
        Effect    = "Allow"
        Resource  = "arn:aws:s3:::wiz-s3-029-306026247677/*"
        Principal = "*"
      }
    ]
  })
}
