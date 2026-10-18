variable "lambda_kms_key_arn" {
  type    = string
  default = null
}

variable "lambda_kms_key_arn_empty" {
  type    = string
  default = ""
}

variable "use_cmk" {
  type    = bool
  default = false
}

variable "environment_variables" {
  type = map(string)
  default = {
    LOG_LEVEL = "info"
  }
}

resource "aws_lambda_function" "sl010_explicit_empty" {
  filename      = "${path.module}/lambda.zip"
  function_name = "c2cgap-sl010-explicit-empty"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"

  environment {
    variables = {
      LOG_LEVEL = "info"
    }
  }

  kms_key_arn = ""

  tags = {
    Rule = "Serverless-010"
  }
}

resource "aws_lambda_function" "sl010_default" {
  filename      = "${path.module}/lambda.zip"
  function_name = "c2cgap-sl010-default"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"

  environment {
    variables = {
      LOG_LEVEL = "info"
    }
  }

  tags = {
    Rule = "Serverless-010"
  }
}

resource "aws_lambda_function" "sl010_dynamic_env" {
  filename      = "${path.module}/lambda.zip"
  function_name = "c2cgap-sl010-dynamic-env"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"

  dynamic "environment" {
    for_each = length(keys(var.environment_variables)) == 0 ? [] : [true]
    content {
      variables = var.environment_variables
    }
  }

  tags = {
    Rule = "Serverless-010"
  }
}

resource "aws_lambda_function" "sl010_var_null" {
  filename      = "${path.module}/lambda.zip"
  function_name = "c2cgap-sl010-var-null"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  kms_key_arn   = var.lambda_kms_key_arn

  environment {
    variables = {
      LOG_LEVEL = "info"
    }
  }

  tags = {
    Rule = "Serverless-010"
  }
}

resource "aws_lambda_function" "sl010_var_empty" {
  filename      = "${path.module}/lambda.zip"
  function_name = "c2cgap-sl010-var-empty"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  kms_key_arn   = var.lambda_kms_key_arn_empty

  environment {
    variables = {
      LOG_LEVEL = "info"
    }
  }

  tags = {
    Rule = "Serverless-010"
  }
}

resource "aws_lambda_function" "sl010_cond_null" {
  filename      = "${path.module}/lambda.zip"
  function_name = "c2cgap-sl010-cond-null"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  kms_key_arn   = var.use_cmk ? "arn:aws:kms:${var.region}:${var.account_id}:key/11111111-2222-3333-4444-555555555555" : null

  environment {
    variables = {
      LOG_LEVEL = "info"
    }
  }

  tags = {
    Rule = "Serverless-010"
  }
}

variable "create_lambda_kms_key" {
  type    = bool
  default = false
}

resource "aws_kms_key" "sl010_cond_resource_key" {
  count               = var.create_lambda_kms_key ? 1 : 0
  description         = "c2cgap-sl010-cond-resource-key"
  enable_key_rotation = true

  tags = {
    Rule = "Serverless-010"
  }
}

resource "aws_lambda_function" "sl010_cond_resource" {
  filename      = "${path.module}/lambda.zip"
  function_name = "c2cgap-sl010-cond-resource"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"
  kms_key_arn   = var.create_lambda_kms_key ? aws_kms_key.sl010_cond_resource_key[0].arn : null

  environment {
    variables = {
      LOG_LEVEL = "info"
    }
  }

  tags = {
    Rule = "Serverless-010"
  }
}
