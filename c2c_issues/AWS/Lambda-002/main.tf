# Lambda-002: Lambda Layer from unrecognized account
# Misconfiguration: Lambda function uses layers from external/unrecognized accounts

variable "lambda_role_arn" {}

data "archive_file" "lambda002_zip" {
  type        = "zip"
  output_path = "${path.module}/lambda002.zip"

  source {
    content  = "def handler(event, context): return 'ok'"
    filename = "index.py"
  }
}

resource "aws_lambda_function" "lambda002_untrusted_layers" {
  function_name = "lambda002-untrusted-layers"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.9"
  filename      = data.archive_file.lambda002_zip.output_path

  # MISCONFIGURATION: layers from unrecognized/external accounts
  layers = [
    "arn:aws:lambda:us-east-1:777777777777:layer:untrusted-layer-1:1",
    "arn:aws:lambda:us-east-1:888888888888:layer:untrusted-layer-2:2"
  ]

  tags = {
    Project = "wiz-policy-testing"
  }
}
