resource "aws_iam_policy" "iam213_v1_inline_jsonencode" {
  name = "c2cgap-iam213-v1-inline-jsonencode"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject"]
        Resource = "*"
      }
    ]
  })

  tags = {
    Rule = "IAM-213"
  }
}

resource "aws_iam_policy" "iam213_v2_heredoc" {
  name   = "c2cgap-iam213-v2-heredoc"
  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Resource": "*"
    }
  ]
}
EOT

  tags = {
    Rule = "IAM-213"
  }
}

data "aws_iam_policy_document" "iam213_v3_policy_document_doc" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "iam213_v3_policy_document" {
  name   = "c2cgap-iam213-v3-policy-document"
  policy = data.aws_iam_policy_document.iam213_v3_policy_document_doc.json

  tags = {
    Rule = "IAM-213"
  }
}

locals {
  iam213_v4_locals_statements = [
    {
      Effect   = "Allow"
      Action   = ["s3:GetObject", "s3:PutObject"]
      Resource = "*"
    }
  ]
  iam213_v8_local_object_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject"]
        Resource = "*"
      }
    ]
  }
  iam213_v9_local_json_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "iam213_v4_locals" {
  name = "c2cgap-iam213-v4-locals"
  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = local.iam213_v4_locals_statements
  })

  tags = {
    Rule = "IAM-213"
  }
}

resource "aws_iam_policy" "iam213_v8_local_object" {
  name   = "c2cgap-iam213-v8-local-object"
  policy = jsonencode(local.iam213_v8_local_object_policy)

  tags = {
    Rule = "IAM-213"
  }
}

resource "aws_iam_policy" "iam213_v9_local_json" {
  name   = "c2cgap-iam213-v9-local-json"
  policy = local.iam213_v9_local_json_policy

  tags = {
    Rule = "IAM-213"
  }
}

resource "aws_iam_policy" "iam213_v10_file" {
  name   = "c2cgap-iam213-v10-file"
  policy = file("${path.module}/policy.json")

  tags = {
    Rule = "IAM-213"
  }
}

resource "aws_iam_policy" "iam213_v11_templatefile" {
  name   = "c2cgap-iam213-v11-templatefile"
  policy = templatefile("${path.module}/policy.json.tpl", { resource = "*" })

  tags = {
    Rule = "IAM-213"
  }
}

data "aws_iam_policy_document" "iam213_v12_grouped_scoped_doc" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::iam213-example-bucket/*"]
  }
}

data "aws_iam_policy_document" "iam213_v12_grouped_doc" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "iam213_v12_grouped_scoped" {
  name   = "c2cgap-iam213-v12-grouped-scoped"
  policy = data.aws_iam_policy_document.iam213_v12_grouped_scoped_doc.json

  tags = {
    Rule = "IAM-213"
  }
}

resource "aws_iam_policy" "iam213_v12_grouped" {
  name   = "c2cgap-iam213-v12-grouped"
  policy = data.aws_iam_policy_document.iam213_v12_grouped_doc.json

  tags = {
    Rule = "IAM-213"
  }
}

resource "awscc_iam_managed_policy" "iam213_v5_awscc_inline" {
  managed_policy_name = "c2cgap-iam213-v5-awscc-inline"
  policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:PutObject"]
        Resource = "*"
      }
    ]
  })
}

data "aws_iam_policy_document" "iam213_v6_awscc_policy_document_doc" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["*"]
  }
}

resource "awscc_iam_managed_policy" "iam213_v6_awscc_policy_document" {
  managed_policy_name = "c2cgap-iam213-v6-awscc-policy-document"
  policy_document     = data.aws_iam_policy_document.iam213_v6_awscc_policy_document_doc.json
}
