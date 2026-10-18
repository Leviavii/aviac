resource "aws_api_gateway_rest_api" "xrayexplicit" {
  name = "c2cgap-apigateway013-xrayexplicit"

  tags = {
    Rule = "APIGateway-013"
  }
}

resource "aws_api_gateway_method" "xrayexplicit_method" {
  rest_api_id   = aws_api_gateway_rest_api.xrayexplicit.id
  resource_id   = aws_api_gateway_rest_api.xrayexplicit.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "xrayexplicit_integration" {
  rest_api_id = aws_api_gateway_rest_api.xrayexplicit.id
  resource_id = aws_api_gateway_rest_api.xrayexplicit.root_resource_id
  http_method = aws_api_gateway_method.xrayexplicit_method.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_deployment" "xrayexplicit_deploy" {
  rest_api_id = aws_api_gateway_rest_api.xrayexplicit.id
  depends_on  = [aws_api_gateway_integration.xrayexplicit_integration]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "xrayexplicit_stage" {
  rest_api_id          = aws_api_gateway_rest_api.xrayexplicit.id
  deployment_id        = aws_api_gateway_deployment.xrayexplicit_deploy.id
  stage_name           = "prod"
  xray_tracing_enabled = false

  tags = {
    Rule = "APIGateway-013"
  }
}

resource "aws_api_gateway_rest_api" "xraydefault" {
  name = "c2cgap-apigateway013-xraydefault"

  tags = {
    Rule = "APIGateway-013"
  }
}

resource "aws_api_gateway_method" "xraydefault_method" {
  rest_api_id   = aws_api_gateway_rest_api.xraydefault.id
  resource_id   = aws_api_gateway_rest_api.xraydefault.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "xraydefault_integration" {
  rest_api_id = aws_api_gateway_rest_api.xraydefault.id
  resource_id = aws_api_gateway_rest_api.xraydefault.root_resource_id
  http_method = aws_api_gateway_method.xraydefault_method.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_deployment" "xraydefault_deploy" {
  rest_api_id = aws_api_gateway_rest_api.xraydefault.id
  depends_on  = [aws_api_gateway_integration.xraydefault_integration]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "xraydefault_stage" {
  rest_api_id   = aws_api_gateway_rest_api.xraydefault.id
  deployment_id = aws_api_gateway_deployment.xraydefault_deploy.id
  stage_name    = "prod"

  tags = {
    Rule = "APIGateway-013"
  }
}

resource "aws_api_gateway_rest_api" "xraydeploystage" {
  name = "c2cgap-apigateway013-xraydeploystage"

  tags = {
    Rule = "APIGateway-013"
  }
}

resource "aws_api_gateway_method" "xraydeploystage_method" {
  rest_api_id   = aws_api_gateway_rest_api.xraydeploystage.id
  resource_id   = aws_api_gateway_rest_api.xraydeploystage.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "xraydeploystage_integration" {
  rest_api_id = aws_api_gateway_rest_api.xraydeploystage.id
  resource_id = aws_api_gateway_rest_api.xraydeploystage.root_resource_id
  http_method = aws_api_gateway_method.xraydeploystage_method.http_method
  type        = "MOCK"
}

resource "awscc_apigateway_deployment" "xraydeploystage_deploy" {
  rest_api_id = aws_api_gateway_rest_api.xraydeploystage.id
  stage_name  = "prod"
  depends_on  = [aws_api_gateway_integration.xraydeploystage_integration]
}
