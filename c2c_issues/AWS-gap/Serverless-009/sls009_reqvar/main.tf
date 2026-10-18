variable "function_name" {
  type = string
}

variable "role_arn" {
  type = string
}

variable "fn_tracing_mode" {
  type = string
}

resource "aws_lambda_function" "sls009_reqvar" {
  function_name = var.function_name
  role          = var.role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  filename      = "${path.module}/../lambda.zip"

  tracing_config {
    mode = var.fn_tracing_mode
  }

  tags = {
    Rule = "Serverless-009"
  }
}
