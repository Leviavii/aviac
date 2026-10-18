resource "aws_iam_user" "iam158_ref" {
  name = "c2cgap-iam158-ref-user"

  tags = {
    Rule = "IAM-158"
  }
}

resource "aws_iam_user_policy" "iam158_ref_inline" {
  name = "c2cgap-iam158-ref-inline"
  user = aws_iam_user.iam158_ref.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::example-bucket/*"
      }
    ]
  })
}

resource "aws_iam_user" "iam158_literal" {
  name = "c2cgap-iam158-literal-user"

  tags = {
    Rule = "IAM-158"
  }
}

resource "aws_iam_user_policy" "iam158_literal_inline" {
  name = "c2cgap-iam158-literal-inline"
  user = "c2cgap-iam158-literal-user"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "ec2:DescribeInstances"
        Resource = "*"
      }
    ]
  })

  depends_on = [aws_iam_user.iam158_literal]
}

resource "aws_iam_user" "iam158_doc" {
  name = "c2cgap-iam158-doc-user"

  tags = {
    Rule = "IAM-158"
  }
}

data "aws_iam_policy_document" "iam158_doc_policy" {
  statement {
    effect    = "Allow"
    actions   = ["sqs:SendMessage"]
    resources = ["arn:aws:sqs:${var.region}:${var.account_id}:example-queue"]
  }
}

resource "aws_iam_user_policy" "iam158_doc_inline" {
  name_prefix = "c2cgap-iam158-doc-"
  user        = aws_iam_user.iam158_doc.name
  policy      = data.aws_iam_policy_document.iam158_doc_policy.json
}

resource "aws_iam_user" "iam158_id" {
  name = "c2cgap-iam158-id-user"
  path = "/system/"

  tags = {
    Rule = "IAM-158"
  }
}

resource "aws_iam_user_policy" "iam158_id_inline" {
  user   = aws_iam_user.iam158_id.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "logs:PutLogEvents",
      "Resource": "*"
    }
  ]
}
POLICY
}
