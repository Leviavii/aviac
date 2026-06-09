# Lambda-003: Lambda function with privileged role
# Misconfiguration: lambda layer version permission grants access to principal "*"

variable "lambda_role_arn" {}

data "archive_file" "lambda003_zip" {
  type        = "zip"
  output_path = "${path.module}/lambda003.zip"

  source {
    content  = "def handler(event, context): return 'ok'"
    filename = "index.py"
  }
}

resource "aws_lambda_layer_version" "lambda003_layer" {
  layer_name          = "lambda003-test-layer"
  filename            = data.archive_file.lambda003_zip.output_path
  compatible_runtimes = ["python3.9"]
}

# MISCONFIGURATION: layer permission grants access to all principals
resource "aws_lambda_layer_version_permission" "lambda003_public_permission" {
  layer_name     = aws_lambda_layer_version.lambda003_layer.layer_name
  version_number = aws_lambda_layer_version.lambda003_layer.version
  statement_id   = "public-access"
  action         = "lambda:GetLayerVersion"
  principal      = "*"
}
