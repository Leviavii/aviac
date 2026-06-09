###############################################################################
# S3-040: S3 bucket public access block should have restrict_public_buckets
# enabled
# Misconfiguration: restrict_public_buckets = false (or missing)
###############################################################################

resource "aws_s3_bucket" "wiz_s3_040" {
  bucket = "wiz-s3-040-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_s3_bucket_public_access_block" "wiz_s3_040" {
  bucket = aws_s3_bucket.wiz_s3_040.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = false
}
