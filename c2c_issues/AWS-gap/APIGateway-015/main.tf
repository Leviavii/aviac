resource "aws_api_gateway_rest_api" "apigw015_explicit" {
  name = "c2cgap-apigateway015-explicit"

  tags = {
    Rule = "APIGateway-015"
  }
}

resource "aws_api_gateway_method" "apigw015_explicit_get" {
  rest_api_id   = aws_api_gateway_rest_api.apigw015_explicit.id
  resource_id   = aws_api_gateway_rest_api.apigw015_explicit.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "apigw015_explicit_get" {
  rest_api_id = aws_api_gateway_rest_api.apigw015_explicit.id
  resource_id = aws_api_gateway_rest_api.apigw015_explicit.root_resource_id
  http_method = aws_api_gateway_method.apigw015_explicit_get.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_deployment" "apigw015_explicit_deployment" {
  rest_api_id = aws_api_gateway_rest_api.apigw015_explicit.id
  depends_on  = [aws_api_gateway_integration.apigw015_explicit_get]
}

resource "aws_api_gateway_stage" "apigw015_explicit_stage" {
  rest_api_id           = aws_api_gateway_rest_api.apigw015_explicit.id
  deployment_id         = aws_api_gateway_deployment.apigw015_explicit_deployment.id
  stage_name            = "prod"
  cache_cluster_enabled = false

  tags = {
    Rule = "APIGateway-015"
  }
}

resource "aws_api_gateway_rest_api" "apigw015_default" {
  name = "c2cgap-apigateway015-default"

  tags = {
    Rule = "APIGateway-015"
  }
}

resource "aws_api_gateway_gateway_response" "apigw015_default_unauthorized" {
  rest_api_id   = aws_api_gateway_rest_api.apigw015_default.id
  response_type = "UNAUTHORIZED"
  status_code   = "401"

  response_templates = {
    "application/json" = "{\"message\":$context.error.messageString}"
  }
}

resource "aws_api_gateway_method" "apigw015_default_get" {
  rest_api_id   = aws_api_gateway_rest_api.apigw015_default.id
  resource_id   = aws_api_gateway_rest_api.apigw015_default.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "apigw015_default_get" {
  rest_api_id = aws_api_gateway_rest_api.apigw015_default.id
  resource_id = aws_api_gateway_rest_api.apigw015_default.root_resource_id
  http_method = aws_api_gateway_method.apigw015_default_get.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_deployment" "apigw015_default_deployment" {
  rest_api_id = aws_api_gateway_rest_api.apigw015_default.id
  depends_on  = [aws_api_gateway_integration.apigw015_default_get]
}

resource "aws_api_gateway_stage" "apigw015_default_stage" {
  rest_api_id   = aws_api_gateway_rest_api.apigw015_default.id
  deployment_id = aws_api_gateway_deployment.apigw015_default_deployment.id
  stage_name    = "prod"

  tags = {
    Rule = "APIGateway-015"
  }
}

resource "aws_api_gateway_rest_api" "apigw015_deploy_stage" {
  name = "c2cgap-apigateway015-deploy-stage"

  tags = {
    Rule = "APIGateway-015"
  }
}

resource "aws_api_gateway_method" "apigw015_deploy_stage_get" {
  rest_api_id   = aws_api_gateway_rest_api.apigw015_deploy_stage.id
  resource_id   = aws_api_gateway_rest_api.apigw015_deploy_stage.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "apigw015_deploy_stage_get" {
  rest_api_id = aws_api_gateway_rest_api.apigw015_deploy_stage.id
  resource_id = aws_api_gateway_rest_api.apigw015_deploy_stage.root_resource_id
  http_method = aws_api_gateway_method.apigw015_deploy_stage_get.http_method
  type        = "MOCK"
}

resource "awscc_apigateway_deployment" "apigw015_deploy_stage_deployment" {
  rest_api_id = aws_api_gateway_rest_api.apigw015_deploy_stage.id
  stage_name  = "prod"
  depends_on  = [aws_api_gateway_integration.apigw015_deploy_stage_get]
}
