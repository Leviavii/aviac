resource "aws_s3_bucket_policy" "s3045_xfile_policy" {
  bucket = aws_s3_bucket.s3045_xfile.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CrossAccountRead"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::033677994240:root"
        }
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::c2cgap-s3045-xfile-${var.account_id}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "s3045_xdoc_policy" {
  bucket = aws_s3_bucket.s3045_xdoc.id
  policy = data.aws_iam_policy_document.s3045_xdoc_doc.json
}
