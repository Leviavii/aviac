###############################################################################
# S3-006: S3 bucket should not allow global READ_ACP ACL permission
# Misconfiguration: grant with READ_ACP permission to AllUsers group
###############################################################################

data "aws_canonical_user_id" "current" {}

resource "aws_s3_bucket" "wiz_s3_006" {
  bucket = "wiz-s3-006-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_s3_bucket_ownership_controls" "wiz_s3_006" {
  bucket = aws_s3_bucket.wiz_s3_006.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "wiz_s3_006" {
  depends_on = [aws_s3_bucket_ownership_controls.wiz_s3_006]
  bucket     = aws_s3_bucket.wiz_s3_006.id
  access_control_policy {

    grant {
      grantee {
        type = "Group"
        uri  = "http://acs.amazonaws.com/groups/global/AllUsers"
      }
      permission = "READ_ACP"
    }

    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
}
