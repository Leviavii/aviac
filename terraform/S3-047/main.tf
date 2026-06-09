###############################################################################
# S3-047: S3 bucket should have a public access block with all restrictions
# enabled
# Misconfiguration: bucket exists with NO aws_s3_bucket_public_access_block
# resource at all (same as S3-046 but separate policy)
###############################################################################

resource "aws_s3_bucket" "wiz_s3_047" {
  bucket = "wiz-s3-047-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}
