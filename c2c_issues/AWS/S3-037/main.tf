###############################################################################
# S3-037: S3 bucket public access block should have block_public_acls enabled
# Misconfiguration: block_public_acls = false (or missing)
###############################################################################

resource "aws_s3_bucket" "wiz_s3_037" {
  bucket = "wiz-s3-037-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_s3_bucket_public_access_block" "wiz_s3_037" {
  bucket = aws_s3_bucket.wiz_s3_037.id

  block_public_acls   = false
  block_public_policy = true
  ignore_public_acls  = true
}
