resource "aws_s3_bucket" "s3045_xfile" {
  bucket = "c2cgap-s3045-xfile-${var.account_id}"

  tags = {
    Rule = "S3-045"
  }
}

resource "aws_s3_bucket" "s3045_xdoc" {
  bucket = "c2cgap-s3045-xdoc-${var.account_id}"

  tags = {
    Rule = "S3-045"
  }
}
