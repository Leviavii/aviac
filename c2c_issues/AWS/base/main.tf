variable "aws_region" {
  default = "us-east-2"
}

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

resource "aws_db_subnet_group" "main" {
  name       = "wiz-policy-testing-db-subnet"
  subnet_ids = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]

  tags = {
    Name    = "wiz-policy-testing-db-subnet"
    Project = "wiz-policy-testing"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "wiz-policy-testing-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })

  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_iam_role" "ecs_task_role" {
  name = "wiz-policy-testing-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })

  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_iam_role" "codebuild_role" {
  name = "wiz-policy-testing-codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
    }]
  })

  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_iam_role" "eks_role" {
  name = "wiz-policy-testing-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })

  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_role.name
}

resource "aws_iam_role" "dms_vpc_role" {
  name = "dms-vpc-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "dms.amazonaws.com"
      }
    }]
  })

  tags = {
    Project = "wiz-policy-testing"
  }
}

resource "aws_iam_role_policy_attachment" "dms_vpc_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"
  role       = aws_iam_role.dms_vpc_role.name
}
