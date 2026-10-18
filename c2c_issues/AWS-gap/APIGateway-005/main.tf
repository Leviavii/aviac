resource "aws_api_gateway_rest_api" "apigw005_explicit" {
  name = "c2cgap-apigateway005-explicit"

  tags = {
    Rule = "APIGateway-005"
  }
}

resource "aws_api_gateway_resource" "apigw005_explicit_items" {
  rest_api_id = aws_api_gateway_rest_api.apigw005_explicit.id
  parent_id   = aws_api_gateway_rest_api.apigw005_explicit.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "apigw005_explicit_get" {
  rest_api_id      = aws_api_gateway_rest_api.apigw005_explicit.id
  resource_id      = aws_api_gateway_resource.apigw005_explicit_items.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = false
}

resource "aws_api_gateway_integration" "apigw005_explicit_get" {
  rest_api_id = aws_api_gateway_rest_api.apigw005_explicit.id
  resource_id = aws_api_gateway_resource.apigw005_explicit_items.id
  http_method = aws_api_gateway_method.apigw005_explicit_get.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_rest_api" "apigw005_default" {
  name = "c2cgap-apigateway005-default"

  tags = {
    Rule = "APIGateway-005"
  }
}

resource "aws_api_gateway_resource" "apigw005_default_items" {
  rest_api_id = aws_api_gateway_rest_api.apigw005_default.id
  parent_id   = aws_api_gateway_rest_api.apigw005_default.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "apigw005_default_get" {
  rest_api_id   = aws_api_gateway_rest_api.apigw005_default.id
  resource_id   = aws_api_gateway_resource.apigw005_default_items.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "apigw005_default_get" {
  rest_api_id = aws_api_gateway_rest_api.apigw005_default.id
  resource_id = aws_api_gateway_resource.apigw005_default_items.id
  http_method = aws_api_gateway_method.apigw005_default_get.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_rest_api" "apigw005_openapi" {
  name = "c2cgap-apigateway005-openapi"
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "c2cgap-apigateway005-openapi"
      version = "1.0"
    }
    paths = {
      "/items" = {
        get = {
          x-amazon-apigateway-integration = {
            type       = "http_proxy"
            httpMethod = "GET"
            uri        = "https://example.com/items"
          }
        }
      }
    }
  })

  tags = {
    Rule = "APIGateway-005"
  }
}

resource "aws_api_gateway_rest_api" "apigw005_gwresp" {
  name = "c2cgap-apigateway005-gwresp"

  tags = {
    Rule = "APIGateway-005"
  }
}

resource "aws_api_gateway_gateway_response" "apigw005_gwresp_unauthorized" {
  rest_api_id   = aws_api_gateway_rest_api.apigw005_gwresp.id
  response_type = "UNAUTHORIZED"
  status_code   = "401"
  response_templates = {
    "application/json" = "{\"message\":$context.error.messageString}"
  }
}

resource "aws_api_gateway_resource" "apigw005_gwresp_items" {
  rest_api_id = aws_api_gateway_rest_api.apigw005_gwresp.id
  parent_id   = aws_api_gateway_rest_api.apigw005_gwresp.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "apigw005_gwresp_get" {
  rest_api_id   = aws_api_gateway_rest_api.apigw005_gwresp.id
  resource_id   = aws_api_gateway_resource.apigw005_gwresp_items.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "apigw005_gwresp_get" {
  rest_api_id = aws_api_gateway_rest_api.apigw005_gwresp.id
  resource_id = aws_api_gateway_resource.apigw005_gwresp_items.id
  http_method = aws_api_gateway_method.apigw005_gwresp_get.http_method
  type        = "MOCK"
}
