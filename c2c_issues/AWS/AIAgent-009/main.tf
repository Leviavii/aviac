# AIAgent-009: AgentCore Runtime VPC Network Mode
# Misconfiguration: network_mode = "PUBLIC" (should be "VPC")
# NOTE: aws_bedrockagentcore_agent_runtime is a newer resource.
# Check Terraform AWS provider version support before deploying.

variable "lambda_role_arn" {}

resource "aws_bedrockagentcore_agent_runtime" "aiagent009_public_runtime" {
  agent_runtime_name = "aiagent009-public-runtime"
  role_arn           = var.lambda_role_arn

  agent_runtime_artifact {
    container_configuration {
      container_uri = "public.ecr.aws/nginx/nginx:latest"
    }
  }

  # MISCONFIGURATION: network_mode is PUBLIC instead of VPC
  network_configuration {
    network_mode = "PUBLIC"
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}
