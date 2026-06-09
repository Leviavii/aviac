# IAM-077: IAM policy allows overly permissive SageMaker access
# Misconfiguration: policy grants sagemaker:CreateNotebookInstance on * with 0.0.0.0/0

resource "aws_iam_role" "iam077_role" {
  name = "iam077-sagemaker-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "sagemaker.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Project = "wiz-policy-testing"
  }
}

# MISCONFIGURATION: overly permissive SageMaker access
resource "aws_iam_role_policy" "iam077_permissive_policy" {
  name = "iam077-permissive-sagemaker"
  role = aws_iam_role.iam077_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sagemaker:CreateNotebookInstance"
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          IpAddress = {
            "aws:SourceIp" = "0.0.0.0/0"
          }
        }
      }
    ]
  })
}
