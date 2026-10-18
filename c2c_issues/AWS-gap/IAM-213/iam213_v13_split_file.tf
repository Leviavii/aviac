resource "aws_iam_policy" "iam213_v13_split_file" {
  name   = "c2cgap-iam213-v13-split-file"
  policy = data.aws_iam_policy_document.iam213_v13_split_file_doc.json

  tags = {
    Rule = "IAM-213"
  }
}
