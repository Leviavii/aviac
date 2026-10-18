variable "role_arn" {
  type = string
}

variable "vpc_subnet_ids" {
  type    = list(string)
  default = null
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = null
}

resource "aws_lambda_function" "srv012_null_vars_dynamic" {
  filename      = "${path.module}/../lambda.zip"
  function_name = "c2cgap-srv012-null-vars-dynamic"
  role          = var.role_arn
  handler       = "index.handler"
  runtime       = "python3.12"

  dynamic "vpc_config" {
    for_each = var.vpc_subnet_ids != null && var.vpc_security_group_ids != null ? [true] : []
    content {
      subnet_ids         = var.vpc_subnet_ids
      security_group_ids = var.vpc_security_group_ids
    }
  }

  tags = {
    Rule = "Serverless-012"
  }
}
