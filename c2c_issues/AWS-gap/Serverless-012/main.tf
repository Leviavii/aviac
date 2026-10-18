resource "aws_lambda_function" "srv012_no_vpc" {
  filename      = "${path.module}/lambda.zip"
  function_name = "c2cgap-srv012-no-vpc"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"

  tags = {
    Rule = "Serverless-012"
  }
}

resource "aws_lambda_function" "srv012_empty_vpc" {
  filename      = "${path.module}/lambda.zip"
  function_name = "c2cgap-srv012-empty-vpc"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  runtime       = "python3.12"

  vpc_config {
    subnet_ids         = []
    security_group_ids = []
  }

  tags = {
    Rule = "Serverless-012"
  }
}

module "srv012_dynamic_vpc" {
  source    = "./srv012_dynamic_vpc"
  role_arn  = var.lambda_role_arn
  vpc_id    = var.vpc_id
  subnet_id = var.subnet_private_a_id
}

module "srv012_var_vpc" {
  source   = "./srv012_var_vpc"
  role_arn = var.lambda_role_arn
}

module "srv012_null_vars_dynamic" {
  source   = "./srv012_null_vars_dynamic"
  role_arn = var.lambda_role_arn
}

module "srv012_cond_vpc" {
  source    = "./srv012_cond_vpc"
  role_arn  = var.lambda_role_arn
  vpc_id    = var.vpc_id
  subnet_id = var.subnet_private_a_id
}
