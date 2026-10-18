data "aws_iam_policy_document" "s3045_xdoc_doc" {
  statement {
    sid    = "CrossAccountWrite"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::033677994240:root"]
    }
    actions   = ["s3:PutObject", "s3:GetObject"]
    resources = ["arn:aws:s3:::c2cgap-s3045-xdoc-${var.account_id}/*"]
  }
}
