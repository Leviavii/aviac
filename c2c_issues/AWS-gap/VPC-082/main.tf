locals {
  vpc082_var_ingress_cidr      = "0.0.0.0/0"
  vpc082_dynamic_ingress_ports = [22, 443]
  vpc082_objdyn_ingress_rules = [
    { port = 80, cidr_blocks = ["0.0.0.0/0"] },
    { port = 443, cidr_blocks = ["0.0.0.0/0"] },
  ]
}

resource "aws_security_group" "vpc082_inline4" {
  name        = "c2cgap-vpc082-inline4"
  description = "Inline ingress open to 0.0.0.0/0"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Rule = "VPC-082"
  }
}

resource "aws_security_group" "vpc082_inline6" {
  name        = "c2cgap-vpc082-inline6"
  description = "Inline ingress open to ::/0"
  vpc_id      = var.vpc_id

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Rule = "VPC-082"
  }
}

resource "aws_security_group" "vpc082_var" {
  name        = "c2cgap-vpc082-var"
  description = "Inline ingress CIDR from variable"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.vpc082_var_ingress_cidr]
  }

  tags = {
    Rule = "VPC-082"
  }
}

resource "aws_security_group" "vpc082_dynamic" {
  name        = "c2cgap-vpc082-dynamic"
  description = "Dynamic ingress blocks open to 0.0.0.0/0"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.vpc082_dynamic_ingress_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Rule = "VPC-082"
  }
}

resource "aws_security_group" "vpc082_sgrule" {
  name        = "c2cgap-vpc082-sgrule"
  description = "Ingress defined in aws_security_group_rule"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-082"
  }
}

resource "aws_security_group_rule" "vpc082_sgrule_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpc082_sgrule.id
}

resource "aws_security_group" "vpc082_vpcrule" {
  name        = "c2cgap-vpc082-vpcrule"
  description = "Ingress defined in aws_vpc_security_group_ingress_rule"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-082"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpc082_vpcrule_ingress" {
  security_group_id = aws_security_group.vpc082_vpcrule.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"

  tags = {
    Rule = "VPC-082"
  }
}

resource "awscc_ec2_security_group" "vpc082_cc_inline" {
  group_name        = "c2cgap-vpc082-cc-inline"
  group_description = "awscc inline ingress open to 0.0.0.0/0"
  vpc_id            = var.vpc_id
  security_group_ingress = [{
    ip_protocol = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_ip     = "0.0.0.0/0"
  }]

  tags = [
    {
      key   = "Rule"
      value = "VPC-082"
    },
    {
      key   = "Project"
      value = "wiz-c2c-gap"
    }
  ]
}

resource "awscc_ec2_security_group" "vpc082_cc_child" {
  group_name        = "c2cgap-vpc082-cc-child"
  group_description = "awscc ingress defined in awscc_ec2_security_group_ingress"
  vpc_id            = var.vpc_id

  tags = [
    {
      key   = "Rule"
      value = "VPC-082"
    },
    {
      key   = "Project"
      value = "wiz-c2c-gap"
    }
  ]
}

resource "awscc_ec2_security_group_ingress" "vpc082_cc_child_ingress" {
  group_id    = awscc_ec2_security_group.vpc082_cc_child.id
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_ip     = "0.0.0.0/0"
}

resource "aws_security_group" "vpc082_multi" {
  name        = "c2cgap-vpc082-multi"
  description = "Two inline ingress blocks, one open to 0.0.0.0/0"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Rule = "VPC-082"
  }
}

resource "aws_security_group" "vpc082_attr" {
  name        = "c2cgap-vpc082-attr"
  description = "Ingress as attribute list of objects"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "https"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Rule = "VPC-082"
  }
}

resource "aws_security_group" "vpc082_objdyn" {
  name        = "c2cgap-vpc082-objdyn"
  description = "Dynamic ingress from list of objects"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = local.vpc082_objdyn_ingress_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  tags = {
    Rule = "VPC-082"
  }
}

resource "aws_security_group" "vpc082_v6rule" {
  name        = "c2cgap-vpc082-v6rule"
  description = "Ingress defined in aws_vpc_security_group_ingress_rule with ::/0"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-082"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpc082_v6rule_ingress" {
  security_group_id = aws_security_group.vpc082_v6rule.id
  cidr_ipv6         = "::/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"

  tags = {
    Rule = "VPC-082"
  }
}
