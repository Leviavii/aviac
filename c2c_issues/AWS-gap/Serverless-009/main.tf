variable "tracing_mode" {
  type    = string
  default = "PassThrough"
}

variable "optional_tracing_mode" {
  type    = string
  default = null
}

resource "aws_lambda_function" "sls009_explicit" {
  function_name = "c2cgap-sls009-explicit"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  filename      = "${path.module}/lambda.zip"

  tracing_config {
    mode = "PassThrough"
  }

  tags = {
    Rule = "Serverless-009"
  }
}

resource "aws_lambda_function" "sls009_omitted" {
  function_name = "c2cgap-sls009-omitted"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  filename      = "${path.module}/lambda.zip"

  tags = {
    Rule = "Serverless-009"
  }
}

resource "aws_lambda_function" "sls009_varmode" {
  function_name = "c2cgap-sls009-varmode"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  filename      = "${path.module}/lambda.zip"

  tracing_config {
    mode = var.tracing_mode
  }

  tags = {
    Rule = "Serverless-009"
  }
}

resource "aws_lambda_function" "sls009_dynoff" {
  function_name = "c2cgap-sls009-dynoff"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  filename      = "${path.module}/lambda.zip"

  dynamic "tracing_config" {
    for_each = var.optional_tracing_mode == null ? [] : [true]
    content {
      mode = var.optional_tracing_mode
    }
  }

  tags = {
    Rule = "Serverless-009"
  }
}

resource "aws_lambda_function" "sls009_dynpass" {
  function_name = "c2cgap-sls009-dynpass"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  filename      = "${path.module}/lambda.zip"

  dynamic "tracing_config" {
    for_each = [var.tracing_mode]
    content {
      mode = tracing_config.value
    }
  }

  tags = {
    Rule = "Serverless-009"
  }
}

variable "enable_xray" {
  type    = bool
  default = false
}

locals {
  tracing_mode = "PassThrough"
}

resource "aws_lambda_function" "sls009_cond" {
  function_name = "c2cgap-sls009-cond"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  filename      = "${path.module}/lambda.zip"

  tracing_config {
    mode = var.enable_xray ? "Active" : "PassThrough"
  }

  tags = {
    Rule = "Serverless-009"
  }
}

resource "aws_lambda_function" "sls009_local" {
  function_name = "c2cgap-sls009-local"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  filename      = "${path.module}/lambda.zip"

  tracing_config {
    mode = local.tracing_mode
  }

  tags = {
    Rule = "Serverless-009"
  }
}

module "sls009_reqvar" {
  source          = "./sls009_reqvar"
  function_name   = "c2cgap-sls009-reqvar"
  role_arn        = var.lambda_role_arn
  fn_tracing_mode = "PassThrough"
}

resource "aws_lambda_function" "sls009_foreach" {
  for_each      = toset(["a", "b"])
  function_name = "c2cgap-sls009-foreach-${each.key}"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  filename      = "${path.module}/lambda.zip"

  tags = {
    Rule = "Serverless-009"
  }
}

variable "fn_settings" {
  type    = map(string)
  default = {}
}

variable "fn_config" {
  type    = any
  default = {}
}

variable "functions" {
  type = map(object({
    tracing_mode = string
  }))
  default = {
    alpha = {
      tracing_mode = "PassThrough"
    }
  }
}

resource "aws_lambda_function" "sls009_lookup" {
  function_name = "c2cgap-sls009-lookup"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  filename      = "${path.module}/lambda.zip"

  tracing_config {
    mode = lookup(var.fn_settings, "tracing_mode", "PassThrough")
  }

  tags = {
    Rule = "Serverless-009"
  }
}

resource "aws_lambda_function" "sls009_try" {
  function_name = "c2cgap-sls009-try"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  filename      = "${path.module}/lambda.zip"

  tracing_config {
    mode = try(var.fn_config.tracing_mode, "PassThrough")
  }

  tags = {
    Rule = "Serverless-009"
  }
}

resource "aws_lambda_function" "sls009_eachval" {
  for_each      = var.functions
  function_name = "c2cgap-sls009-eachval-${each.key}"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  filename      = "${path.module}/lambda.zip"

  tracing_config {
    mode = each.value.tracing_mode
  }

  tags = {
    Rule = "Serverless-009"
  }
}
