resource "aws_iam_user" "iam_001_managed_attach" {
  name = "c2cgap-iam001-managed-attach"
  tags = {
    Rule = "IAM-001"
  }
}

resource "aws_iam_user_policy_attachment" "iam_001_managed_attach_ro" {
  user       = aws_iam_user.iam_001_managed_attach.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_user" "iam_001_customer_managed" {
  name = "c2cgap-iam001-customer-managed"
  tags = {
    Rule = "IAM-001"
  }
}

data "aws_iam_policy_document" "iam_001_customer_managed_doc" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::example-bucket/*"]
  }
}

resource "aws_iam_policy" "iam_001_customer_managed_policy" {
  name   = "c2cgap-iam001-customer-managed-policy"
  policy = data.aws_iam_policy_document.iam_001_customer_managed_doc.json
  tags = {
    Rule = "IAM-001"
  }
}

resource "aws_iam_user_policy_attachment" "iam_001_customer_managed_attach" {
  user       = aws_iam_user.iam_001_customer_managed.name
  policy_arn = aws_iam_policy.iam_001_customer_managed_policy.arn
}

resource "aws_iam_user" "iam_001_shared_attach" {
  name = "c2cgap-iam001-shared-attach"
  tags = {
    Rule = "IAM-001"
  }
}

data "aws_iam_policy_document" "iam_001_shared_attach_doc" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::example-bucket/*"]
  }
}

resource "aws_iam_policy" "iam_001_shared_attach_policy" {
  name   = "c2cgap-iam001-shared-attach-policy"
  policy = data.aws_iam_policy_document.iam_001_shared_attach_doc.json
  tags = {
    Rule = "IAM-001"
  }
}

resource "aws_iam_policy_attachment" "iam_001_shared_attach_admin" {
  name       = "c2cgap-iam001-shared-attach-admin"
  users      = [aws_iam_user.iam_001_shared_attach.name]
  policy_arn = aws_iam_policy.iam_001_shared_attach_policy.arn
}

resource "aws_iam_user" "iam_001_exclusive_attach" {
  name = "c2cgap-iam001-exclusive-attach"
  tags = {
    Rule = "IAM-001"
  }
}

resource "aws_iam_user_policy_attachments_exclusive" "iam_001_exclusive_attach_set" {
  user_name   = aws_iam_user.iam_001_exclusive_attach.name
  policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}

resource "aws_iam_user" "iam_001_inline_only" {
  name = "c2cgap-iam001-inline-only"
  tags = {
    Rule = "IAM-001"
  }
}

resource "aws_iam_user_policy" "iam_001_inline_only_policy" {
  name = "c2cgap-iam001-inline-only-policy"
  user = aws_iam_user.iam_001_inline_only.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["ec2:Describe*"]
      Resource = "*"
    }]
  })
}

resource "aws_iam_user" "iam_001_inline_and_managed" {
  name = "c2cgap-iam001-inline-and-managed"
  tags = {
    Rule = "IAM-001"
  }
}

resource "aws_iam_user_policy" "iam_001_inline_and_managed_inline" {
  name = "c2cgap-iam001-inline-and-managed-inline"
  user = aws_iam_user.iam_001_inline_and_managed.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["ec2:Describe*"]
      Resource = "*"
    }]
  })
}

resource "aws_iam_user_policies_exclusive" "iam_001_inline_and_managed_inline_set" {
  user_name    = aws_iam_user.iam_001_inline_and_managed.name
  policy_names = [aws_iam_user_policy.iam_001_inline_and_managed_inline.name]
}

resource "aws_iam_user_policy_attachment" "iam_001_inline_and_managed_attach" {
  user       = aws_iam_user.iam_001_inline_and_managed.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_user" "iam_001_foreach" {
  for_each = toset(["c2cgap-iam001-foreach-a", "c2cgap-iam001-foreach-b"])
  name     = each.value
  tags = {
    Rule = "IAM-001"
  }
}

resource "aws_iam_user_policy_attachment" "iam_001_foreach_attach" {
  for_each   = aws_iam_user.iam_001_foreach
  user       = each.value.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
