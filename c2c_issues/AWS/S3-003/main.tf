###############################################################################
# S3-003: S3 bucket should not allow global WRITE_ACP ACL permission
# Misconfiguration: grant with WRITE_ACP permission to AllUsers group
###############################################################################

data "aws_canonical_user_id" "current" {}

resource "aws_s3_bucket" "wiz_s3_003" {
  bucket = "wiz-s3-003-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_s3_bucket_ownership_controls" "wiz_s3_003" {
  bucket = aws_s3_bucket.wiz_s3_003.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "wiz_s3_003" {
  depends_on = [aws_s3_bucket_ownership_controls.wiz_s3_003]
  bucket     = aws_s3_bucket.wiz_s3_003.id
  access_control_policy {

    grant {
      grantee {
        type = "Group"
        uri  = "http://acs.amazonaws.com/groups/global/AllUsers"
      }
      permission = "WRITE_ACP"
    }

    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
}
