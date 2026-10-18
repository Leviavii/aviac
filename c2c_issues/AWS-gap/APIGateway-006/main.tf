resource "aws_api_gateway_rest_api" "restsplit" {
  name = "c2cgap-apigateway006-restsplit"

  tags = {
    Rule = "APIGateway-006"
  }
}

resource "aws_api_gateway_resource" "restsplit_res" {
  rest_api_id = aws_api_gateway_rest_api.restsplit.id
  parent_id   = aws_api_gateway_rest_api.restsplit.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "restsplit_method" {
  rest_api_id   = aws_api_gateway_rest_api.restsplit.id
  resource_id   = aws_api_gateway_resource.restsplit_res.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "restsplit_integration" {
  rest_api_id = aws_api_gateway_rest_api.restsplit.id
  resource_id = aws_api_gateway_resource.restsplit_res.id
  http_method = aws_api_gateway_method.restsplit_method.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_deployment" "restsplit_deploy" {
  rest_api_id = aws_api_gateway_rest_api.restsplit.id
  depends_on  = [aws_api_gateway_integration.restsplit_integration]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "restsplit_stage" {
  rest_api_id   = aws_api_gateway_rest_api.restsplit.id
  deployment_id = aws_api_gateway_deployment.restsplit_deploy.id
  stage_name    = "prod"

  tags = {
    Rule = "APIGateway-006"
  }
}

resource "aws_api_gateway_rest_api" "restdeploy" {
  name = "c2cgap-apigateway006-restdeploy"

  tags = {
    Rule = "APIGateway-006"
  }
}

resource "aws_api_gateway_resource" "restdeploy_res" {
  rest_api_id = aws_api_gateway_rest_api.restdeploy.id
  parent_id   = aws_api_gateway_rest_api.restdeploy.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "restdeploy_method" {
  rest_api_id   = aws_api_gateway_rest_api.restdeploy.id
  resource_id   = aws_api_gateway_resource.restdeploy_res.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "restdeploy_integration" {
  rest_api_id = aws_api_gateway_rest_api.restdeploy.id
  resource_id = aws_api_gateway_resource.restdeploy_res.id
  http_method = aws_api_gateway_method.restdeploy_method.http_method
  type        = "MOCK"
}

resource "awscc_apigateway_deployment" "restdeploy_deploy" {
  rest_api_id = aws_api_gateway_rest_api.restdeploy.id
  stage_name  = "prod"
  depends_on  = [aws_api_gateway_integration.restdeploy_integration]
}

resource "aws_api_gateway_rest_api" "restbody" {
  name = "c2cgap-apigateway006-restbody"
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "c2cgap-apigateway006-restbody"
      version = "1.0"
    }
    paths = {
      "/items" = {
        get = {
          x-amazon-apigateway-integration = {
            type = "mock"
            requestTemplates = {
              "application/json" = "{\"statusCode\": 200}"
            }
          }
        }
      }
    }
  })

  tags = {
    Rule = "APIGateway-006"
  }
}

resource "aws_api_gateway_deployment" "restbody_deploy" {
  rest_api_id = aws_api_gateway_rest_api.restbody.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.restbody.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "restbody_stage" {
  rest_api_id          = aws_api_gateway_rest_api.restbody.id
  deployment_id        = aws_api_gateway_deployment.restbody_deploy.id
  stage_name           = "prod"
  xray_tracing_enabled = true

  tags = {
    Rule = "APIGateway-006"
  }
}

resource "aws_apigatewayv2_api" "wssplit" {
  name                       = "c2cgap-apigateway006-wssplit"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"

  tags = {
    Rule = "APIGateway-006"
  }
}

resource "aws_apigatewayv2_integration" "wssplit_integration" {
  api_id           = aws_apigatewayv2_api.wssplit.id
  integration_type = "MOCK"
}

resource "aws_apigatewayv2_route" "wssplit_route" {
  api_id    = aws_apigatewayv2_api.wssplit.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.wssplit_integration.id}"
}

resource "aws_apigatewayv2_stage" "wssplit_stage" {
  api_id      = aws_apigatewayv2_api.wssplit.id
  name        = "prod"
  auto_deploy = true

  tags = {
    Rule = "APIGateway-006"
  }
}
