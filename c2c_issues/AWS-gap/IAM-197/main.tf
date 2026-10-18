resource "awscc_iam_managed_policy" "iam197_awscc" {
  managed_policy_name = "c2cgap-iam197-awscc"
  policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "iam197_jsonencode" {
  name = "c2cgap-iam197-jsonencode"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      }
    ]
  })
  tags = {
    Rule = "IAM-197"
  }
}

resource "aws_iam_policy" "iam197_heredoc" {
  name   = "c2cgap-iam197-heredoc"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["dynamodb:*", "ec2:DescribeInstances"],
      "Resource": "*"
    }
  ]
}
POLICY
  tags = {
    Rule = "IAM-197"
  }
}

resource "aws_iam_policy" "iam197_file" {
  name   = "c2cgap-iam197-file"
  policy = file("${path.module}/iam197_file.json")
  tags = {
    Rule = "IAM-197"
  }
}

locals {
  iam197_locals_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["ec2:*"]
        Resource = "*"
      }
    ]
  }
}

resource "aws_iam_policy" "iam197_locals" {
  name   = "c2cgap-iam197-locals"
  policy = jsonencode(local.iam197_locals_policy)
  tags = {
    Rule = "IAM-197"
  }
}

resource "aws_iam_policy" "iam197_tmpl" {
  name = "c2cgap-iam197-tmpl"
  policy = templatefile("${path.module}/iam197_tmpl.json.tpl", {
    service = "sns"
  })
  tags = {
    Rule = "IAM-197"
  }
}

resource "aws_iam_policy" "iam197_docsrc" {
  name   = "c2cgap-iam197-docsrc"
  policy = data.aws_iam_policy_document.iam197_docsrc_doc.json
  tags = {
    Rule = "IAM-197"
  }
}

resource "aws_iam_policy" "iam197_docnoeffect" {
  name   = "c2cgap-iam197-docnoeffect"
  policy = data.aws_iam_policy_document.iam197_docnoeffect_doc.json
  tags = {
    Rule = "IAM-197"
  }
}

data "aws_iam_policy_document" "iam197_docsrc_doc" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "iam197_docnoeffect_doc" {
  statement {
    actions   = ["sqs:*"]
    resources = ["*"]
  }
}
