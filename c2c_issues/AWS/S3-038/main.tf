###############################################################################
# S3-038: S3 bucket public access block should have ignore_public_acls enabled
# Misconfiguration: ignore_public_acls = false
###############################################################################

resource "aws_s3_bucket" "wiz_s3_038" {
  bucket = "wiz-s3-038-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_s3_bucket_public_access_block" "wiz_s3_038" {
  bucket = aws_s3_bucket.wiz_s3_038.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = false
}
