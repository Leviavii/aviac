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

resource "aws_security_group" "srv012_cond_vpc_sg" {
  name        = "c2cgap-srv012-cond-vpc-sg"
  description = "c2cgap Serverless-012 cond_vpc"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "Serverless-012"
  }
}

resource "aws_lambda_function" "srv012_cond_vpc" {
  filename      = "${path.module}/../lambda.zip"
  function_name = "c2cgap-srv012-cond-vpc"
  role          = var.role_arn
  handler       = "index.handler"
  runtime       = "python3.12"

  vpc_config {
    subnet_ids         = var.enable_vpc ? [var.subnet_id] : []
    security_group_ids = var.enable_vpc ? [aws_security_group.srv012_cond_vpc_sg.id] : []
  }

  tags = {
    Rule = "Serverless-012"
  }
}
