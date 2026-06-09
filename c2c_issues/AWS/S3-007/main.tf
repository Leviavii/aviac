###############################################################################
# S3-007: S3 bucket should not allow global access (any permission to
# AllUsers or AuthenticatedUsers group)
# Misconfiguration: grant with READ_ACP to AuthenticatedUsers group
###############################################################################

data "aws_canonical_user_id" "current" {}

resource "aws_s3_bucket" "wiz_s3_007" {
  bucket = "wiz-s3-007-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_s3_bucket_ownership_controls" "wiz_s3_007" {
  bucket = aws_s3_bucket.wiz_s3_007.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "wiz_s3_007" {
  depends_on = [aws_s3_bucket_ownership_controls.wiz_s3_007]
  bucket     = aws_s3_bucket.wiz_s3_007.id
  access_control_policy {
    grant {
      grantee {
        id   = data.aws_canonical_user_id.current.id
        type = "CanonicalUser"
      }
      permission = "READ"
    }

    grant {
      grantee {
        type = "Group"
        uri  = "http://acs.amazonaws.com/groups/global/AuthenticatedUsers"
      }
      permission = "READ_ACP"
    }

    owner {
      id = data.aws_canonical_user_id.current.id
    }
  }
}
