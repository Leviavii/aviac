resource "aws_api_gateway_rest_api" "apigw009_body" {
  name = "c2cgap-apigateway009-body"
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "c2cgap-apigateway009-body"
      version = "1.0"
    }
    paths = {
      "/items" = {
        get = {
          parameters = [
            {
              name     = "id"
              in       = "query"
              required = true
              schema   = { type = "string" }
            }
          ]
          x-amazon-apigateway-integration = {
            type       = "HTTP_PROXY"
            httpMethod = "GET"
            uri        = "https://example.com/items"
          }
        }
      }
    }
  })

  tags = {
    Rule = "APIGateway-009"
  }
}

resource "aws_api_gateway_rest_api" "apigw009_default" {
  name = "c2cgap-apigateway009-default"

  tags = {
    Rule = "APIGateway-009"
  }
}

resource "aws_api_gateway_resource" "apigw009_default_items" {
  rest_api_id = aws_api_gateway_rest_api.apigw009_default.id
  parent_id   = aws_api_gateway_rest_api.apigw009_default.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "apigw009_default_get" {
  rest_api_id   = aws_api_gateway_rest_api.apigw009_default.id
  resource_id   = aws_api_gateway_resource.apigw009_default_items.id
  http_method   = "GET"
  authorization = "NONE"

  request_parameters = {
    "method.request.querystring.id" = true
  }
}

resource "aws_api_gateway_integration" "apigw009_default_get" {
  rest_api_id             = aws_api_gateway_rest_api.apigw009_default.id
  resource_id             = aws_api_gateway_resource.apigw009_default_items.id
  http_method             = aws_api_gateway_method.apigw009_default_get.http_method
  type                    = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = "https://example.com/items"
}

resource "aws_api_gateway_rest_api" "apigw009_validator_unused" {
  name = "c2cgap-apigateway009-validator-unused"

  tags = {
    Rule = "APIGateway-009"
  }
}

resource "aws_api_gateway_request_validator" "apigw009_validator_unused_validator" {
  name                        = "validate-params"
  rest_api_id                 = aws_api_gateway_rest_api.apigw009_validator_unused.id
  validate_request_body       = true
  validate_request_parameters = true
}

resource "aws_api_gateway_method" "apigw009_validator_unused_post" {
  rest_api_id   = aws_api_gateway_rest_api.apigw009_validator_unused.id
  resource_id   = aws_api_gateway_rest_api.apigw009_validator_unused.root_resource_id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "apigw009_validator_unused_post" {
  rest_api_id             = aws_api_gateway_rest_api.apigw009_validator_unused.id
  resource_id             = aws_api_gateway_rest_api.apigw009_validator_unused.root_resource_id
  http_method             = aws_api_gateway_method.apigw009_validator_unused_post.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.apigw009_validator_unused_fn.invoke_arn
}

data "archive_file" "apigw009_validator_unused_fn_zip" {
  type        = "zip"
  output_path = "${path.module}/apigw009_validator_unused_fn.zip"

  source {
    content  = "def handler(event, context):\n    return {\"statusCode\": 200, \"body\": \"ok\"}\n"
    filename = "index.py"
  }
}

resource "aws_lambda_function" "apigw009_validator_unused_fn" {
  function_name    = "c2cgap-apigateway009-validator-unused"
  role             = var.lambda_role_arn
  handler          = "index.handler"
  runtime          = "python3.12"
  filename         = data.archive_file.apigw009_validator_unused_fn_zip.output_path
  source_code_hash = data.archive_file.apigw009_validator_unused_fn_zip.output_base64sha256

  tags = {
    Rule = "APIGateway-009"
  }
}

resource "aws_api_gateway_gateway_response" "apigw009_gwresp" {
  rest_api_id   = aws_api_gateway_rest_api.apigw009_gwresp_api.id
  response_type = "BAD_REQUEST_PARAMETERS"
  status_code   = "400"

  response_templates = {
    "application/json" = "{\"message\":$context.error.validationErrorString}"
  }
}

resource "aws_api_gateway_rest_api" "apigw009_gwresp_api" {
  name = "c2cgap-apigateway009-gwresp"

  tags = {
    Rule = "APIGateway-009"
  }
}

resource "aws_api_gateway_method" "apigw009_gwresp_api_get" {
  rest_api_id   = aws_api_gateway_rest_api.apigw009_gwresp_api.id
  resource_id   = aws_api_gateway_rest_api.apigw009_gwresp_api.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "apigw009_gwresp_api_get" {
  rest_api_id = aws_api_gateway_rest_api.apigw009_gwresp_api.id
  resource_id = aws_api_gateway_rest_api.apigw009_gwresp_api.root_resource_id
  http_method = aws_api_gateway_method.apigw009_gwresp_api_get.http_method
  type        = "MOCK"
}
