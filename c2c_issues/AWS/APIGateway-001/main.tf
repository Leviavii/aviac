# APIGateway-001: REST API Gateway private endpoints only
# Misconfiguration: endpoint type is REGIONAL instead of PRIVATE

resource "aws_api_gateway_rest_api" "apigateway001_regional" {
  name = "apigateway001-regional-api"

  # MISCONFIGURATION: type is REGIONAL instead of PRIVATE
  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = {
    Project = "wiz-policy-testing"
  }
}
