resource "aws_s3_bucket" "s3045_filefn" {
  bucket = "c2cgap-s3045-filefn-${var.account_id}"

  tags = {
    Rule = "S3-045"
  }
}

resource "aws_s3_bucket_policy" "s3045_filefn_policy" {
  bucket = aws_s3_bucket.s3045_filefn.id
  policy = file("${path.module}/s3045_filefn_policy.json")
}

resource "aws_s3_bucket" "s3045_tmplfn" {
  bucket = "c2cgap-s3045-tmplfn-${var.account_id}"

  tags = {
    Rule = "S3-045"
  }
}

resource "aws_s3_bucket_policy" "s3045_tmplfn_policy" {
  bucket = aws_s3_bucket.s3045_tmplfn.id
  policy = templatefile("${path.module}/s3045_tmplfn_policy.json.tpl", { bucket_arn = aws_s3_bucket.s3045_tmplfn.arn })
}
