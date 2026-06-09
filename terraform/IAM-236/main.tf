# IAM-236: Bedrock Service Role confused deputy
# Misconfiguration: Bedrock role with overly broad permissions without confused deputy protection

resource "aws_iam_role" "iam236_bedrock_role" {
  name = "iam236-bedrock-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "bedrock.amazonaws.com"
        }
        # MISCONFIGURATION: no condition for confused deputy protection
        # (missing aws:SourceAccount or aws:SourceArn)
      }
    ]
  })

  tags = {
    Project = "wiz-policy-testing"
  }
}

# MISCONFIGURATION: overly broad bedrock:* permissions
resource "aws_iam_role_policy" "iam236_bedrock_policy" {
  name = "iam236-bedrock-policy"
  role = aws_iam_role.iam236_bedrock_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "bedrock:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
