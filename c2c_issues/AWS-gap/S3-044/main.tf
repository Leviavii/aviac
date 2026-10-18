resource "aws_s3_bucket" "s3044_acl_preferred" {
  bucket = "c2cgap-s3044-acl-preferred-${var.account_id}"

  tags = {
    Rule = "S3-044"
  }
}

resource "aws_s3_bucket_ownership_controls" "s3044_acl_preferred_ownership" {
  bucket = aws_s3_bucket.s3044_acl_preferred.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3044_acl_preferred_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.s3044_acl_preferred_ownership]

  bucket = aws_s3_bucket.s3044_acl_preferred.id
  acl    = "private"
}

resource "aws_s3_bucket" "s3044_logs_writer" {
  bucket = "c2cgap-s3044-logs-writer-${var.account_id}"

  tags = {
    Rule = "S3-044"
  }
}

resource "aws_s3_bucket_ownership_controls" "s3044_logs_writer_ownership" {
  bucket = aws_s3_bucket.s3044_logs_writer.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket" "s3044_defaults_only" {
  bucket = "c2cgap-s3044-defaults-only-${var.account_id}"

  tags = {
    Rule = "S3-044"
  }
}
