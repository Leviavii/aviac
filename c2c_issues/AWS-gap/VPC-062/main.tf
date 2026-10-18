locals {
  vpc062_dynamic_rules = [
    {
      description = "all traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

resource "aws_security_group" "vpc062_public_inline" {
  name        = "c2cgap-vpc062-public-inline"
  description = "All traffic from anywhere"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Rule = "VPC-062"
  }
}

resource "aws_security_group" "vpc062_private_inline" {
  name        = "c2cgap-vpc062-private-inline"
  description = "All traffic from the internal network"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8"]
  }

  tags = {
    Rule = "VPC-062"
  }
}

resource "aws_security_group" "vpc062_tcp_sgsrc_source" {
  name        = "c2cgap-vpc062-tcp-sgsrc-source"
  description = "Source security group for vpc062_tcp_sgsrc"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-062"
  }
}

resource "aws_security_group" "vpc062_tcp_sgsrc" {
  name        = "c2cgap-vpc062-tcp-sgsrc"
  description = "All TCP ports from the load balancer security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.vpc062_tcp_sgsrc_source.id]
  }

  tags = {
    Rule = "VPC-062"
  }
}

resource "aws_security_group" "vpc062_sgrule" {
  name        = "c2cgap-vpc062-sgrule"
  description = "Rules managed separately"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-062"
  }
}

resource "aws_security_group_rule" "vpc062_sgrule_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpc062_sgrule.id
}

resource "aws_security_group" "vpc062_vpcrule" {
  name        = "c2cgap-vpc062-vpcrule"
  description = "Rules managed separately"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-062"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpc062_vpcrule_ingress" {
  security_group_id = aws_security_group.vpc062_vpcrule.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Rule = "VPC-062"
  }
}

resource "aws_security_group" "vpc062_vpctcp" {
  name        = "c2cgap-vpc062-vpctcp"
  description = "Rules managed separately"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-062"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpc062_vpctcp_ingress" {
  security_group_id = aws_security_group.vpc062_vpctcp.id
  ip_protocol       = "tcp"
  from_port         = 0
  to_port           = 65535
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Rule = "VPC-062"
  }
}

resource "aws_security_group" "vpc062_dynamic" {
  name        = "c2cgap-vpc062-dynamic"
  description = "Rules from a dynamic block"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.vpc062_dynamic_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  tags = {
    Rule = "VPC-062"
  }
}

resource "awscc_ec2_security_group" "vpc062_awscc" {
  group_name        = "c2cgap-vpc062-awscc"
  group_description = "All traffic from anywhere"
  vpc_id            = var.vpc_id
  security_group_ingress = [
    {
      ip_protocol = "-1"
      cidr_ip     = "0.0.0.0/0"
    }
  ]

  tags = [
    {
      key   = "Rule"
      value = "VPC-062"
    },
    {
      key   = "Project"
      value = "wiz-c2c-gap"
    }
  ]
}
