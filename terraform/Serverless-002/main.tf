# Serverless-002: Lambda function URL auth type NONE
# Misconfiguration: authorization_type = "NONE" on function URL

variable "lambda_role_arn" {}

data "archive_file" "serverless002_zip" {
  type        = "zip"
  output_path = "${path.module}/serverless002.zip"

  source {
    content  = "exports.handler = async (event) => { return { statusCode: 200, body: 'ok' }; };"
    filename = "index.js"
  }
}

resource "aws_lambda_function" "serverless002_function" {
  filename      = data.archive_file.serverless002_zip.output_path
  function_name = "serverless002-no-auth-url"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  tags = {
    Project = "wiz-policy-testing"
  }
}

# MISCONFIGURATION: function URL with no authorization
resource "aws_lambda_function_url" "serverless002_no_auth" {
  function_name      = aws_lambda_function.serverless002_function.function_name
  authorization_type = "NONE"
}
