resource "aws_iam_policy" "iam213_v7_doc_declared_after" {
  name   = "c2cgap-iam213-v7-doc-declared-after"
  policy = data.aws_iam_policy_document.iam213_v7_doc_declared_after_doc.json

  tags = {
    Rule = "IAM-213"
  }
}

data "aws_iam_policy_document" "iam213_v7_doc_declared_after_doc" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["*"]
  }
}
