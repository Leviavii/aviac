resource "aws_iam_role" "explicit_heredoc" {
  name               = "c2cgap-iam057-explicit-heredoc"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::444455556666:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
  tags = {
    Rule = "IAM-057"
  }
}

resource "aws_iam_role" "jsonenc" {
  name = "c2cgap-iam057-jsonenc"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::444455556666:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Rule = "IAM-057"
  }
}

data "aws_iam_policy_document" "policydoc_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::444455556666:root"]
    }
  }
}

resource "aws_iam_role" "policydoc" {
  name               = "c2cgap-iam057-policydoc"
  assume_role_policy = data.aws_iam_policy_document.policydoc_trust.json
  tags = {
    Rule = "IAM-057"
  }
}

resource "aws_iam_role" "stswildcard" {
  name = "c2cgap-iam057-stswildcard"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::444455556666:root"
        }
        Action = "sts:*"
      }
    ]
  })
  tags = {
    Rule = "IAM-057"
  }
}

resource "terraform_data" "nodefaultvar_partner" {
  input = "444455556666"
}

resource "aws_iam_role" "nodefaultvar" {
  name = "c2cgap-iam057-nodefaultvar"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${terraform_data.nodefaultvar_partner.output}:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Rule = "IAM-057"
  }
}

data "aws_partition" "partitionarn_current" {}

resource "aws_iam_role" "partitionarn" {
  name = "c2cgap-iam057-partitionarn"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:${data.aws_partition.partitionarn_current.partition}:iam::444455556666:root"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Rule = "IAM-057"
  }
}

resource "aws_iam_role" "bareacct" {
  name = "c2cgap-iam057-bareacct"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "444455556666"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Rule = "IAM-057"
  }
}

resource "aws_iam_role" "actionlist" {
  name = "c2cgap-iam057-actionlist"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = ["arn:aws:iam::444455556666:root"]
        }
        Action = ["sts:AssumeRole", "sts:TagSession"]
      }
    ]
  })
  tags = {
    Rule = "IAM-057"
  }
}
