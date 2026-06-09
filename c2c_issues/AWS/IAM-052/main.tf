# IAM-052: Resource policy allows all principals with ForAllValues
# Misconfiguration: API Gateway policy uses ForAllValues:StringLike with wildcard principal

resource "aws_api_gateway_rest_api" "iam052_api" {
  name = "iam052-test-api"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}

# MISCONFIGURATION: policy allows all principals with ForAllValues condition
resource "aws_api_gateway_rest_api_policy" "iam052_overly_permissive" {
  rest_api_id = aws_api_gateway_rest_api.iam052_api.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action   = "execute-api:Invoke"
        Resource = "*"
        Condition = {
          "ForAllValues:StringLike" = {
            "aws:PrincipalArn" = "arn:aws:iam::123456789012:role/test-role"
          }
        }
      }
    ]
  })
}
