resource "aws_sns_topic" "sns009_inline" {
  name = "c2cgap-sns009-inline"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowAccountPublish"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${var.account_id}:root" }
        Action    = ["SNS:Publish", "SNS:Subscribe"]
        Resource  = "arn:aws:sns:${var.region}:${var.account_id}:c2cgap-sns009-inline"
      }
    ]
  })

  tags = {
    Rule = "SNS-009"
  }
}

resource "aws_sns_topic" "sns009_nopolicy" {
  name = "c2cgap-sns009-nopolicy"

  tags = {
    Rule = "SNS-009"
  }
}

resource "aws_sns_topic" "sns009_separate" {
  name = "c2cgap-sns009-separate"

  tags = {
    Rule = "SNS-009"
  }
}

resource "aws_sns_topic_policy" "sns009_separate_policy" {
  arn = aws_sns_topic.sns009_separate.arn

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowAccountPublish"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${var.account_id}:root" }
        Action    = ["SNS:Publish", "SNS:Subscribe"]
        Resource  = aws_sns_topic.sns009_separate.arn
      }
    ]
  })
}

resource "aws_sns_topic" "sns009_doc_separate" {
  name = "c2cgap-sns009-doc-separate"

  tags = {
    Rule = "SNS-009"
  }
}

data "aws_iam_policy_document" "sns009_doc_separate_doc" {
  statement {
    sid     = "AllowAccountPublish"
    effect  = "Allow"
    actions = ["SNS:Publish", "SNS:Subscribe"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:root"]
    }

    resources = [aws_sns_topic.sns009_doc_separate.arn]
  }
}

resource "aws_sns_topic_policy" "sns009_doc_separate_policy" {
  arn    = aws_sns_topic.sns009_doc_separate.arn
  policy = data.aws_iam_policy_document.sns009_doc_separate_doc.json
}

data "aws_iam_policy_document" "sns009_doc_inline_doc" {
  statement {
    sid     = "AllowAccountPublish"
    effect  = "Allow"
    actions = ["SNS:Publish", "SNS:Subscribe"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.account_id}:root"]
    }

    resources = ["arn:aws:sns:${var.region}:${var.account_id}:c2cgap-sns009-doc-inline"]
  }
}

resource "aws_sns_topic" "sns009_doc_inline" {
  name   = "c2cgap-sns009-doc-inline"
  policy = data.aws_iam_policy_document.sns009_doc_inline_doc.json

  tags = {
    Rule = "SNS-009"
  }
}

resource "aws_sns_topic" "sns009_heredoc" {
  name = "c2cgap-sns009-heredoc"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowAccountPublish",
      "Effect": "Allow",
      "Principal": { "AWS": "arn:aws:iam::${var.account_id}:root" },
      "Action": ["SNS:Publish", "SNS:Subscribe"],
      "Resource": "arn:aws:sns:${var.region}:${var.account_id}:c2cgap-sns009-heredoc"
    }
  ]
}
POLICY

  tags = {
    Rule = "SNS-009"
  }
}

resource "aws_sns_topic" "sns009_file" {
  name   = "c2cgap-sns009-file"
  policy = file("${path.module}/sns009_file_policy.json")

  tags = {
    Rule = "SNS-009"
  }
}
