###############################################################################
# S3-012: S3 bucket public access block should have all parameters set to true
# Misconfiguration: block_public_acls = false (while others are true)
###############################################################################

resource "aws_s3_bucket" "wiz_s3_012" {
  bucket = "wiz-s3-012-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_s3_bucket_public_access_block" "wiz_s3_012" {
  bucket = aws_s3_bucket.wiz_s3_012.id

  block_public_acls       = false
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
