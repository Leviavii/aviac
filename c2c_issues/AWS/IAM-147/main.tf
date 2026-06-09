# IAM-147: IAM Role allows all principals to assume
# Misconfiguration: assume_role_policy Principal AWS = "*"

resource "aws_iam_role" "iam147_open_role" {
  name = "iam147-open-assume-role"

  # MISCONFIGURATION: any AWS principal can assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
          AWS     = "*"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })

  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_iam_instance_profile" "iam147_profile" {
  name = "iam147-open-instance-profile"
  role = aws_iam_role.iam147_open_role.name

  tags = {
    Project = "wiz-policy-testing"
  }
}
