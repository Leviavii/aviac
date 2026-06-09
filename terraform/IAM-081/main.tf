# IAM-081: IAM policy allows assume role across all services
# Misconfiguration: policy grants sts:AssumeRole on Resource = "*"

resource "aws_iam_role" "iam081_role" {
  name = "iam081-assume-all-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Project = "wiz-policy-testing"
  }
}

# MISCONFIGURATION: policy allows STS:AssumeRole on all resources
resource "aws_iam_role_policy" "iam081_assume_all_policy" {
  name = "iam081-assume-all-policy"
  role = aws_iam_role.iam081_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "STS:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
