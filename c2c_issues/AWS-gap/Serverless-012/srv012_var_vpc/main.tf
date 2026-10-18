variable "role_arn" {
  type = string
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

resource "aws_lambda_function" "srv012_var_vpc" {
  filename      = "${path.module}/../lambda.zip"
  function_name = "c2cgap-srv012-var-vpc"
  role          = var.role_arn
  handler       = "index.handler"
  runtime       = "python3.12"

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  tags = {
    Rule = "Serverless-012"
  }
}
