resource "aws_sqs_queue" "sqs_010_default" {
  name = "c2cgap-sqs010-default"

  tags = {
    Rule = "SQS-010"
  }
}

resource "aws_sqs_queue" "sqs_010_inline_allow" {
  name = "c2cgap-sqs010-inline-allow"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowSnsSend"
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = "arn:aws:sqs:${var.region}:${var.account_id}:c2cgap-sqs010-inline-allow"
        Condition = {
          ArnEquals = { "aws:SourceArn" = "arn:aws:sns:${var.region}:${var.account_id}:c2cgap-sqs010-topic" }
        }
      }
    ]
  })

  tags = {
    Rule = "SQS-010"
  }
}

resource "aws_sqs_queue" "sqs_010_allow_https" {
  name = "c2cgap-sqs010-allow-https"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowOnlyHttps"
        Effect    = "Allow"
        Principal = { AWS = "arn:aws:iam::${var.account_id}:root" }
        Action    = "sqs:*"
        Resource  = "arn:aws:sqs:${var.region}:${var.account_id}:c2cgap-sqs010-allow-https"
        Condition = {
          Bool = { "aws:SecureTransport" = "true" }
        }
      }
    ]
  })

  tags = {
    Rule = "SQS-010"
  }
}

resource "aws_sqs_queue" "sqs_010_deny_list" {
  name = "c2cgap-sqs010-deny-list"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyInsecureTransport"
        Effect    = "Deny"
        Principal = "*"
        Action    = "sqs:*"
        Resource  = "arn:aws:sqs:${var.region}:${var.account_id}:c2cgap-sqs010-deny-list"
        Condition = {
          Bool = { "aws:SecureTransport" = ["false"] }
        }
      }
    ]
  })

  tags = {
    Rule = "SQS-010"
  }
}

resource "aws_sqs_queue" "sqs_010_qp_deny_list" {
  name = "c2cgap-sqs010-qp-deny-list"

  tags = {
    Rule = "SQS-010"
  }
}

resource "aws_sqs_queue_policy" "sqs_010_qp_deny_list_policy" {
  queue_url = aws_sqs_queue.sqs_010_qp_deny_list.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyInsecureTransport"
        Effect    = "Deny"
        Principal = "*"
        Action    = "sqs:*"
        Resource  = aws_sqs_queue.sqs_010_qp_deny_list.arn
        Condition = {
          Bool = { "aws:SecureTransport" = ["false"] }
        }
      }
    ]
  })
}

resource "aws_sqs_queue" "sqs_010_separate" {
  name = "c2cgap-sqs010-separate"

  tags = {
    Rule = "SQS-010"
  }
}

resource "aws_sqs_queue_policy" "sqs_010_separate_policy" {
  queue_url = aws_sqs_queue.sqs_010_separate.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowSnsSend"
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.sqs_010_separate.arn
      }
    ]
  })
}

resource "aws_sqs_queue" "sqs_010_policydoc" {
  name = "c2cgap-sqs010-policydoc"

  tags = {
    Rule = "SQS-010"
  }
}

data "aws_iam_policy_document" "sqs_010_policydoc_doc" {
  statement {
    sid    = "AllowSnsSend"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }
    actions   = ["sqs:SendMessage"]
    resources = [aws_sqs_queue.sqs_010_policydoc.arn]
  }
}

resource "aws_sqs_queue_policy" "sqs_010_policydoc_policy" {
  queue_url = aws_sqs_queue.sqs_010_policydoc.id
  policy    = data.aws_iam_policy_document.sqs_010_policydoc_doc.json
}

resource "awscc_sqs_queue" "sqs_010_cc_default" {
  queue_name = "c2cgap-sqs010-cc-default"

  tags = [
    {
      key   = "Rule"
      value = "SQS-010"
    }
  ]
}

resource "awscc_sqs_queue" "sqs_010_cc_inline" {
  queue_name = "c2cgap-sqs010-cc-inline"

  tags = [
    {
      key   = "Rule"
      value = "SQS-010"
    }
  ]
}

resource "awscc_sqs_queue_inline_policy" "sqs_010_cc_inline_policy" {
  queue = awscc_sqs_queue.sqs_010_cc_inline.queue_url
  policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowSnsSend"
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = awscc_sqs_queue.sqs_010_cc_inline.arn
      }
    ]
  })
}

resource "aws_sqs_queue" "sqs_010_heredoc" {
  name = "c2cgap-sqs010-heredoc"

  tags = {
    Rule = "SQS-010"
  }
}

resource "aws_sqs_queue_policy" "sqs_010_heredoc_policy" {
  queue_url = aws_sqs_queue.sqs_010_heredoc.id
  policy    = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowSnsSend",
      "Effect": "Allow",
      "Principal": { "Service": "sns.amazonaws.com" },
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sqs_010_heredoc.arn}"
    }
  ]
}
POLICY
}

resource "aws_sqs_queue" "sqs_010_override" {
  name = "c2cgap-sqs010-override"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyInsecureTransport"
        Effect    = "Deny"
        Principal = "*"
        Action    = "sqs:*"
        Resource  = "arn:aws:sqs:${var.region}:${var.account_id}:c2cgap-sqs010-override"
        Condition = {
          Bool = { "aws:SecureTransport" = "false" }
        }
      }
    ]
  })

  tags = {
    Rule = "SQS-010"
  }
}

resource "aws_sqs_queue_policy" "sqs_010_override_policy" {
  queue_url = aws_sqs_queue.sqs_010_override.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowSnsSend"
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.sqs_010_override.arn
      }
    ]
  })
}
