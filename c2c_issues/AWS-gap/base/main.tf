data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpc" "main" {
  id = "vpc-0b6352d73ace64d6b"
}

data "aws_subnet" "public_a" {
  id = "subnet-0bf79cdce6f1ba783"
}

data "aws_subnet" "public_b" {
  id = "subnet-032ce6b451acafe0e"
}

data "aws_subnet" "private_a" {
  id = "subnet-0a29225784b760c1e"
}

resource "aws_iam_role" "lambda_role" {
  name = "c2cgap-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role" "ecs_task_role" {
  name = "c2cgap-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ecs-tasks.amazonaws.com" }
    }]
  })
}
