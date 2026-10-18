resource "aws_security_group" "sg_inline_range" {
  name        = "c2cgap-vpc086-sg-inline-range"
  description = "Inline outbound TCP port range"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Rule = "VPC-086"
  }
}

resource "aws_security_group" "sg_inline_all" {
  name        = "c2cgap-vpc086-sg-inline-all"
  description = "Inline outbound all protocols"
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Rule = "VPC-086"
  }
}

resource "aws_security_group" "sg_rule_range" {
  name        = "c2cgap-vpc086-sg-rule-range"
  description = "Outbound via aws_security_group_rule port range"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-086"
  }
}

resource "aws_security_group_rule" "sg_rule_range_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_rule_range.id
}

resource "aws_security_group" "sg_rule_all" {
  name        = "c2cgap-vpc086-sg-rule-all"
  description = "Outbound via aws_security_group_rule all protocols"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-086"
  }
}

resource "aws_security_group_rule" "sg_rule_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_rule_all.id
}

resource "aws_security_group" "sg_vpcrule_range" {
  name        = "c2cgap-vpc086-sg-vpcrule-range"
  description = "Outbound via standalone vpc rule port range"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-086"
  }
}

resource "aws_vpc_security_group_egress_rule" "sg_vpcrule_range_egress" {
  security_group_id = aws_security_group.sg_vpcrule_range.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 0
  to_port           = 65535

  tags = {
    Rule = "VPC-086"
  }
}

resource "aws_security_group" "sg_vpcrule_all" {
  name        = "c2cgap-vpc086-sg-vpcrule-all"
  description = "Outbound via standalone vpc rule all protocols"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-086"
  }
}

resource "aws_vpc_security_group_egress_rule" "sg_vpcrule_all_egress" {
  security_group_id = aws_security_group.sg_vpcrule_all.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Rule = "VPC-086"
  }
}

resource "awscc_ec2_security_group" "sg_cc_default" {
  group_name        = "c2cgap-vpc086-sg-cc-default"
  group_description = "Cloud Control SG with no outbound rules set"
  vpc_id            = var.vpc_id

  tags = [
    {
      key   = "Rule"
      value = "VPC-086"
    },
    {
      key   = "Project"
      value = "wiz-c2c-gap"
    }
  ]
}

resource "awscc_ec2_security_group" "sg_cc_range" {
  group_name        = "c2cgap-vpc086-sg-cc-range"
  group_description = "Cloud Control SG with outbound port range"
  vpc_id            = var.vpc_id
  security_group_egress = [{
    ip_protocol = "tcp"
    from_port   = 0
    to_port     = 65535
    cidr_ip     = "0.0.0.0/0"
  }]

  tags = [
    {
      key   = "Rule"
      value = "VPC-086"
    },
    {
      key   = "Project"
      value = "wiz-c2c-gap"
    }
  ]
}
