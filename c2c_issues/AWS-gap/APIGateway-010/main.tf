resource "aws_api_gateway_rest_api" "v1stage" {
  name = "c2cgap-apigateway010-v1stage"

  tags = {
    Rule = "APIGateway-010"
  }
}

resource "aws_api_gateway_resource" "v1stage_res" {
  rest_api_id = aws_api_gateway_rest_api.v1stage.id
  parent_id   = aws_api_gateway_rest_api.v1stage.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "v1stage_method" {
  rest_api_id   = aws_api_gateway_rest_api.v1stage.id
  resource_id   = aws_api_gateway_resource.v1stage_res.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "v1stage_integration" {
  rest_api_id = aws_api_gateway_rest_api.v1stage.id
  resource_id = aws_api_gateway_resource.v1stage_res.id
  http_method = aws_api_gateway_method.v1stage_method.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_deployment" "v1stage_deploy" {
  rest_api_id = aws_api_gateway_rest_api.v1stage.id
  depends_on  = [aws_api_gateway_integration.v1stage_integration]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "v1stage_stage" {
  rest_api_id   = aws_api_gateway_rest_api.v1stage.id
  deployment_id = aws_api_gateway_deployment.v1stage_deploy.id
  stage_name    = "prod"

  tags = {
    Rule = "APIGateway-010"
  }
}

resource "aws_api_gateway_rest_api" "v1deploy" {
  name = "c2cgap-apigateway010-v1deploy"

  tags = {
    Rule = "APIGateway-010"
  }
}

resource "aws_api_gateway_resource" "v1deploy_res" {
  rest_api_id = aws_api_gateway_rest_api.v1deploy.id
  parent_id   = aws_api_gateway_rest_api.v1deploy.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "v1deploy_method" {
  rest_api_id   = aws_api_gateway_rest_api.v1deploy.id
  resource_id   = aws_api_gateway_resource.v1deploy_res.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "v1deploy_integration" {
  rest_api_id = aws_api_gateway_rest_api.v1deploy.id
  resource_id = aws_api_gateway_resource.v1deploy_res.id
  http_method = aws_api_gateway_method.v1deploy_method.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_deployment" "v1deploy_deploy" {
  rest_api_id = aws_api_gateway_rest_api.v1deploy.id
  depends_on  = [aws_api_gateway_integration.v1deploy_integration]
}

resource "awscc_apigateway_deployment" "v1deploy_deploy_stage" {
  rest_api_id = aws_api_gateway_rest_api.v1deploy.id
  stage_name  = "prod"
  depends_on  = [aws_api_gateway_integration.v1deploy_integration]
}

resource "aws_apigatewayv2_api" "v2stage" {
  name          = "c2cgap-apigateway010-v2stage"
  protocol_type = "HTTP"

  tags = {
    Rule = "APIGateway-010"
  }
}

resource "aws_apigatewayv2_stage" "v2stage_stage" {
  api_id      = aws_apigatewayv2_api.v2stage.id
  name        = "$default"
  auto_deploy = true

  tags = {
    Rule = "APIGateway-010"
  }
}

data "archive_file" "v2quick_fn_zip" {
  type        = "zip"
  output_path = "${path.module}/v2quick_fn.zip"

  source {
    content  = "def handler(event, context):\n    return {\"statusCode\": 200, \"body\": \"ok\"}\n"
    filename = "index.py"
  }
}

resource "aws_lambda_function" "v2quick_fn" {
  function_name    = "c2cgap-apigateway010-v2quick-fn"
  role             = var.lambda_role_arn
  handler          = "index.handler"
  runtime          = "python3.12"
  filename         = data.archive_file.v2quick_fn_zip.output_path
  source_code_hash = data.archive_file.v2quick_fn_zip.output_base64sha256

  tags = {
    Rule = "APIGateway-010"
  }
}

resource "aws_apigatewayv2_api" "v2quick" {
  name          = "c2cgap-apigateway010-v2quick"
  protocol_type = "HTTP"
  target        = aws_lambda_function.v2quick_fn.arn

  tags = {
    Rule = "APIGateway-010"
  }
}

resource "aws_iam_role" "v2ws_apigw_cw_role" {
  name = "c2cgap-apigateway010-v2ws-apigw-cw"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "apigateway.amazonaws.com" }
    }]
  })

  tags = {
    Rule = "APIGateway-010"
  }
}

resource "aws_iam_role_policy_attachment" "v2ws_apigw_cw_role" {
  role       = aws_iam_role.v2ws_apigw_cw_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"
}

resource "aws_api_gateway_account" "v2ws_apigw_account" {
  cloudwatch_role_arn = aws_iam_role.v2ws_apigw_cw_role.arn

  depends_on = [aws_iam_role_policy_attachment.v2ws_apigw_cw_role]
}

resource "aws_apigatewayv2_api" "v2ws" {
  name                       = "c2cgap-apigateway010-v2ws"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"

  tags = {
    Rule = "APIGateway-010"
  }
}

resource "aws_apigatewayv2_stage" "v2ws_stage" {
  api_id = aws_apigatewayv2_api.v2ws.id
  name   = "prod"

  default_route_settings {
    logging_level          = "INFO"
    data_trace_enabled     = true
    throttling_burst_limit = 100
    throttling_rate_limit  = 50
  }

  tags = {
    Rule = "APIGateway-010"
  }

  depends_on = [aws_api_gateway_account.v2ws_apigw_account]
}

resource "aws_api_gateway_rest_api" "v1gw" {
  name = "c2cgap-apigateway010-v1gw"

  tags = {
    Rule = "APIGateway-010"
  }
}

resource "aws_api_gateway_gateway_response" "v1gw" {
  rest_api_id   = aws_api_gateway_rest_api.v1gw.id
  response_type = "DEFAULT_4XX"

  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Origin" = "'*'"
  }

  response_templates = {
    "application/json" = "{\"message\":$context.error.messageString}"
  }
}

resource "aws_api_gateway_resource" "v1gw_res" {
  rest_api_id = aws_api_gateway_rest_api.v1gw.id
  parent_id   = aws_api_gateway_rest_api.v1gw.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "v1gw_method" {
  rest_api_id   = aws_api_gateway_rest_api.v1gw.id
  resource_id   = aws_api_gateway_resource.v1gw_res.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "v1gw_integration" {
  rest_api_id = aws_api_gateway_rest_api.v1gw.id
  resource_id = aws_api_gateway_resource.v1gw_res.id
  http_method = aws_api_gateway_method.v1gw_method.http_method
  type        = "MOCK"
}

resource "aws_api_gateway_deployment" "v1gw_deploy" {
  rest_api_id = aws_api_gateway_rest_api.v1gw.id
  depends_on  = [aws_api_gateway_integration.v1gw_integration, aws_api_gateway_gateway_response.v1gw]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "v1gw_stage" {
  rest_api_id   = aws_api_gateway_rest_api.v1gw.id
  deployment_id = aws_api_gateway_deployment.v1gw_deploy.id
  stage_name    = "prod"

  tags = {
    Rule = "APIGateway-010"
  }
}
