resource "aws_api_gateway_rest_api" "apigw008_explicit" {
  name = "c2cgap-apigateway008-explicit"

  tags = {
    Rule = "APIGateway-008"
  }
}

resource "aws_api_gateway_resource" "apigw008_explicit_items" {
  rest_api_id = aws_api_gateway_rest_api.apigw008_explicit.id
  parent_id   = aws_api_gateway_rest_api.apigw008_explicit.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "apigw008_explicit_get" {
  rest_api_id   = aws_api_gateway_rest_api.apigw008_explicit.id
  resource_id   = aws_api_gateway_resource.apigw008_explicit_items.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_rest_api" "apigw008_options" {
  name = "c2cgap-apigateway008-options"

  tags = {
    Rule = "APIGateway-008"
  }
}

resource "aws_api_gateway_resource" "apigw008_options_items" {
  rest_api_id = aws_api_gateway_rest_api.apigw008_options.id
  parent_id   = aws_api_gateway_rest_api.apigw008_options.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "apigw008_options_preflight" {
  rest_api_id   = aws_api_gateway_rest_api.apigw008_options.id
  resource_id   = aws_api_gateway_resource.apigw008_options_items.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_rest_api" "apigw008_openapi" {
  name = "c2cgap-apigateway008-openapi"
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "c2cgap-apigateway008-openapi"
      version = "1.0"
    }
    paths = {
      "/items" = {
        get = {
          x-amazon-apigateway-integration = {
            type                 = "HTTP_PROXY"
            httpMethod           = "GET"
            uri                  = "https://example.com/items"
            payloadFormatVersion = "1.0"
          }
        }
      }
    }
  })

  tags = {
    Rule = "APIGateway-008"
  }
}

resource "aws_api_gateway_rest_api" "apigw008_root" {
  name = "c2cgap-apigateway008-root"

  tags = {
    Rule = "APIGateway-008"
  }
}

resource "aws_api_gateway_method" "apigw008_root_any" {
  rest_api_id   = aws_api_gateway_rest_api.apigw008_root.id
  resource_id   = aws_api_gateway_rest_api.apigw008_root.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "apigw008_root_any" {
  rest_api_id             = aws_api_gateway_rest_api.apigw008_root.id
  resource_id             = aws_api_gateway_rest_api.apigw008_root.root_resource_id
  http_method             = aws_api_gateway_method.apigw008_root_any.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "ANY"
  uri                     = "https://example.com/"
}
