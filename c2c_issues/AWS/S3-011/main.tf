###############################################################################
# S3-011: S3 bucket should not be publicly exposed to the internet
# Misconfiguration: bucket ACL set to "public-read"
# Note: The old-style 'acl' attribute on aws_s3_bucket is deprecated.
# Modern AWS requires using aws_s3_bucket_acl + ownership controls.
###############################################################################

resource "aws_s3_bucket" "wiz_s3_011" {
  bucket = "wiz-s3-011-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_s3_bucket_ownership_controls" "wiz_s3_011" {
  bucket = aws_s3_bucket.wiz_s3_011.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "wiz_s3_011" {
  depends_on = [aws_s3_bucket_ownership_controls.wiz_s3_011]
  bucket     = aws_s3_bucket.wiz_s3_011.id
  acl        = "public-read"
}
