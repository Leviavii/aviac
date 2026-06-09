###############################################################################
# PrivateEndpoint-001: S3 Access Point should have public_access_block_configuration
# defined with all settings enabled
# Misconfiguration: access point with NO public_access_block_configuration
###############################################################################

resource "aws_s3_bucket" "wiz_privateendpoint_001" {
  bucket = "wiz-privateendpoint-001-306026247677"
  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_s3_access_point" "wiz_privateendpoint_001" {
  bucket = aws_s3_bucket.wiz_privateendpoint_001.id
  name   = "wiz-pe001-no-config-ap"
}
