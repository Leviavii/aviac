# AIGateway-001: AgentCore Gateway authorization
# Misconfiguration: authorizer_type = "NONE" (should be "CUSTOM_JWT" or "AWS_IAM")
# NOTE: aws_bedrockagentcore_gateway is a newer resource.
# Check Terraform AWS provider version support before deploying.

variable "lambda_role_arn" {}

resource "aws_bedrockagentcore_gateway" "aigateway001_noncompliant" {
  name            = "aigateway001-no-auth"
  protocol_type   = "MCP"
  role_arn        = var.lambda_role_arn
  # MISCONFIGURATION: authorizer_type is NONE instead of CUSTOM_JWT or AWS_IAM
  authorizer_type = "NONE"

  tags = {
    Project = "wiz-policy-testing"
  }
}
