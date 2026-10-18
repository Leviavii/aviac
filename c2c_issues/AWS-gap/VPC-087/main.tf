resource "aws_security_group" "vpc087_inline_range" {
  name        = "c2cgap-vpc087-inline-range"
  description = "Inline ingress with port range"
  vpc_id      = var.vpc_id

  ingress {
    description = "App ports"
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Rule = "VPC-087"
  }
}

resource "aws_security_group" "vpc087_inline_all" {
  name        = "c2cgap-vpc087-inline-all"
  description = "Inline ingress all traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "All traffic from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Rule = "VPC-087"
  }
}

resource "aws_security_group" "vpc087_rule_range" {
  name        = "c2cgap-vpc087-rule-range"
  description = "Separate aws_security_group_rule with port range"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-087"
  }
}

resource "aws_security_group_rule" "vpc087_rule_range_ingress" {
  type              = "ingress"
  from_port         = 1024
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.vpc087_rule_range.id
}

resource "aws_security_group" "vpc087_rule_all" {
  name        = "c2cgap-vpc087-rule-all"
  description = "Separate aws_security_group_rule all traffic"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-087"
  }
}

resource "aws_security_group_rule" "vpc087_rule_all_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.vpc087_rule_all.id
}

resource "aws_security_group" "vpc087_vpcrule_range" {
  name        = "c2cgap-vpc087-vpcrule-range"
  description = "Separate aws_vpc_security_group_ingress_rule with port range"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-087"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpc087_vpcrule_range_ingress" {
  security_group_id = aws_security_group.vpc087_vpcrule_range.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 1024
  to_port           = 65535
  ip_protocol       = "tcp"

  tags = {
    Rule = "VPC-087"
  }
}

resource "aws_security_group" "vpc087_vpcrule_all" {
  name        = "c2cgap-vpc087-vpcrule-all"
  description = "Separate aws_vpc_security_group_ingress_rule all traffic"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-087"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpc087_vpcrule_all_ingress" {
  security_group_id = aws_security_group.vpc087_vpcrule_all.id
  cidr_ipv4         = "10.0.0.0/16"
  ip_protocol       = "-1"

  tags = {
    Rule = "VPC-087"
  }
}

locals {
  vpc087_dynamic_range_ports = [
    { from = 443, to = 443 },
    { from = 8000, to = 8999 },
  ]
}

resource "aws_security_group" "vpc087_dynamic_range" {
  name        = "c2cgap-vpc087-dynamic-range"
  description = "Dynamic ingress blocks with a port range"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.vpc087_dynamic_range_ports
    content {
      from_port   = ingress.value.from
      to_port     = ingress.value.to
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    }
  }

  tags = {
    Rule = "VPC-087"
  }
}

resource "awscc_ec2_security_group" "vpc087_awscc_range" {
  group_name        = "c2cgap-vpc087-awscc-range"
  group_description = "AWSCC security group with port range"
  vpc_id            = var.vpc_id
  security_group_ingress = [{
    ip_protocol = "tcp"
    from_port   = 1024
    to_port     = 65535
    cidr_ip     = "10.0.0.0/16"
  }]

  tags = [
    {
      key   = "Rule"
      value = "VPC-087"
    }
  ]
}

resource "aws_security_group" "vpc087_sgrule_wideall" {
  name        = "c2cgap-vpc087-sgrule-wideall"
  description = "Separate aws_security_group_rule all traffic with 0-65535 ports"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-087"
  }
}

resource "aws_security_group_rule" "vpc087_sgrule_wideall_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.vpc087_sgrule_wideall.id
}

resource "aws_security_group" "vpc087_inline_icmp" {
  name        = "c2cgap-vpc087-inline-icmp"
  description = "Inline ICMP echo request"
  vpc_id      = var.vpc_id

  ingress {
    description = "Ping"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  tags = {
    Rule = "VPC-087"
  }
}
