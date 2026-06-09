###############################################################################
# S3-039: S3 bucket public access block should have block_public_policy enabled
# Misconfiguration: block_public_policy = false (and no account-level override)
###############################################################################

resource "aws_s3_bucket" "wiz_s3_039" {
  bucket = "wiz-s3-039-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_s3_bucket_public_access_block" "wiz_s3_039" {
  bucket = aws_s3_bucket.wiz_s3_039.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
