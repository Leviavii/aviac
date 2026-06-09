###############################################################################
# S3-005: S3 bucket should not allow global WRITE ACL permission
# Misconfiguration: grant with WRITE permission to AllUsers group
###############################################################################

data "aws_canonical_user_id" "current" {}

resource "aws_s3_bucket" "wiz_s3_005" {
  bucket = "wiz-s3-005-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_s3_bucket_ownership_controls" "wiz_s3_005" {
  bucket = aws_s3_bucket.wiz_s3_005.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "wiz_s3_005" {
  depends_on = [aws_s3_bucket_ownership_controls.wiz_s3_005]
  bucket     = aws_s3_bucket.wiz_s3_005.id
  access_control_policy {

    grant {
      grantee {
        type = "Group"
        uri  = "http://acs.amazonaws.com/groups/global/AllUsers"
      }
      permission = "WRITE"
    }

    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
}
