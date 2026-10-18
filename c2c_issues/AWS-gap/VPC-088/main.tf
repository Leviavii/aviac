resource "aws_security_group" "sg_inline" {
  name        = "c2cgap-vpc088-sg-inline"
  description = "inline egress all protocols"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Rule = "VPC-088"
  }
}

resource "aws_security_group" "sg_dynamic" {
  name        = "c2cgap-vpc088-sg-dynamic"
  description = "dynamic egress all protocols"
  vpc_id      = var.vpc_id

  dynamic "egress" {
    for_each = [{ protocol = "-1", cidr = "0.0.0.0/0" }]
    content {
      from_port   = 0
      to_port     = 0
      protocol    = egress.value.protocol
      cidr_blocks = [egress.value.cidr]
    }
  }

  tags = {
    Rule = "VPC-088"
  }
}

resource "aws_security_group" "sg_number" {
  name        = "c2cgap-vpc088-sg-number"
  description = "inline egress protocol as unquoted number -1"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Rule = "VPC-088"
  }
}

resource "aws_security_group" "sg_legacyrule" {
  name        = "c2cgap-vpc088-sg-legacyrule"
  description = "egress via aws_security_group_rule"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-088"
  }
}

resource "aws_security_group_rule" "sg_legacyrule_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_legacyrule.id
}

resource "aws_security_group" "sg_vpcrule" {
  name        = "c2cgap-vpc088-sg-vpcrule"
  description = "egress via aws_vpc_security_group_egress_rule"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-088"
  }
}

resource "aws_vpc_security_group_egress_rule" "sg_vpcrule_egress" {
  security_group_id = aws_security_group.sg_vpcrule.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Rule = "VPC-088"
  }
}

resource "awscc_ec2_security_group" "cc_explicit" {
  group_name        = "c2cgap-vpc088-cc-explicit"
  group_description = "awscc explicit egress all protocols"
  vpc_id            = var.vpc_id
  security_group_egress = [
    {
      ip_protocol = "-1"
      cidr_ip     = "0.0.0.0/0"
    }
  ]

  tags = [
    {
      key   = "Rule"
      value = "VPC-088"
    }
  ]
}

resource "awscc_ec2_security_group" "cc_default" {
  group_name        = "c2cgap-vpc088-cc-default"
  group_description = "awscc no egress, AWS default allow-all egress remains"
  vpc_id            = var.vpc_id

  tags = [
    {
      key   = "Rule"
      value = "VPC-088"
    }
  ]
}
