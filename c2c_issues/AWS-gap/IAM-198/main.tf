resource "aws_iam_policy" "iam198_jsonenc" {
  name = "c2cgap-iam198-jsonenc"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "kms:Decrypt"
        Resource = "*"
      }
    ]
  })
  tags = {
    Rule = "IAM-198"
  }
}

resource "aws_iam_policy" "iam198_heredoc" {
  name   = "c2cgap-iam198-heredoc"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:GenerateDataKey"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
  tags = {
    Rule = "IAM-198"
  }
}

data "aws_iam_policy_document" "iam198_datadoc_kms" {
  statement {
    effect    = "Allow"
    actions   = ["kms:Decrypt", "kms:ReEncryptFrom"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "iam198_datadoc" {
  name   = "c2cgap-iam198-datadoc"
  policy = data.aws_iam_policy_document.iam198_datadoc_kms.json
  tags = {
    Rule = "IAM-198"
  }
}

resource "aws_iam_policy" "iam198_file" {
  name   = "c2cgap-iam198-file"
  policy = file("${path.module}/iam198_file_policy.json")
  tags = {
    Rule = "IAM-198"
  }
}

resource "awscc_iam_managed_policy" "iam198_awscc" {
  managed_policy_name = "c2cgap-iam198-awscc"
  policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}

data "aws_iam_policy_document" "iam198_noeffect_kms" {
  statement {
    actions   = ["kms:Decrypt"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "iam198_noeffect" {
  name   = "c2cgap-iam198-noeffect"
  policy = data.aws_iam_policy_document.iam198_noeffect_kms.json
  tags = {
    Rule = "IAM-198"
  }
}

locals {
  iam198_local_doc = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["kms:Decrypt"]
        Resource = ["*"]
      }
    ]
  }
}

resource "aws_iam_policy" "iam198_local" {
  name   = "c2cgap-iam198-local"
  policy = jsonencode(local.iam198_local_doc)
  tags = {
    Rule = "IAM-198"
  }
}
