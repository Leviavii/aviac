variable "role_arn" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "enable_vpc" {
  type    = bool
  default = false
}

resource "aws_security_group" "srv012_dynamic_vpc_sg" {
  name        = "c2cgap-srv012-dynamic-vpc-sg"
  description = "c2cgap Serverless-012 dynamic_vpc"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "Serverless-012"
  }
}

resource "aws_lambda_function" "srv012_dynamic_vpc" {
  filename      = "${path.module}/../lambda.zip"
  function_name = "c2cgap-srv012-dynamic-vpc"
  role          = var.role_arn
  handler       = "index.handler"
  runtime       = "python3.12"

  dynamic "vpc_config" {
    for_each = var.enable_vpc ? [1] : []
    content {
      subnet_ids         = [var.subnet_id]
      security_group_ids = [aws_security_group.srv012_dynamic_vpc_sg.id]
    }
  }

  tags = {
    Rule = "Serverless-012"
  }
}
