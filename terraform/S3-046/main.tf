###############################################################################
# S3-046: S3 bucket should have a public access block with all restrictions
# enabled
# Misconfiguration: bucket exists with NO aws_s3_bucket_public_access_block
# resource at all
###############################################################################

resource "aws_s3_bucket" "wiz_s3_046" {
  bucket = "wiz-s3-046-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}
