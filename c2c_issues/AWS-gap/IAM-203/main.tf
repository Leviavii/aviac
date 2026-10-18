resource "aws_iam_role" "iam203_inline" {
  name = "c2cgap-iam203-inline"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Rule = "IAM-203"
  }
}

resource "aws_iam_role" "iam203_svclist" {
  name = "c2cgap-iam203-svclist"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = ["ecs-tasks.amazonaws.com", "ec2.amazonaws.com"]
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Rule = "IAM-203"
  }
}

resource "aws_iam_role" "iam203_heredoc" {
  name = "c2cgap-iam203-heredoc"

  assume_role_policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOT

  tags = {
    Rule = "IAM-203"
  }
}

data "aws_iam_policy_document" "iam203_pdoc_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam203_pdoc" {
  name               = "c2cgap-iam203-pdoc"
  assume_role_policy = data.aws_iam_policy_document.iam203_pdoc_trust.json

  tags = {
    Rule = "IAM-203"
  }
}

resource "aws_iam_role" "iam203_extid" {
  name = "c2cgap-iam203-extid"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "events.amazonaws.com"
        }
        Action = "sts:AssumeRole"
        Condition = {
          StringEquals = {
            "sts:ExternalId" = "111122223333"
          }
        }
      }
    ]
  })

  tags = {
    Rule = "IAM-203"
  }
}

resource "aws_iam_role" "iam203_file" {
  name               = "c2cgap-iam203-file"
  assume_role_policy = file("${path.module}/iam203_file_trust.json")

  tags = {
    Rule = "IAM-203"
  }
}

locals {
  iam203_local_trust = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role" "iam203_local" {
  name               = "c2cgap-iam203-local"
  assume_role_policy = local.iam203_local_trust

  tags = {
    Rule = "IAM-203"
  }
}
