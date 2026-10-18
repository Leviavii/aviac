data "aws_iam_policy_document" "iam213_v13_split_file_doc" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["*"]
  }
}
