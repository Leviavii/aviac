resource "aws_security_group" "vpc056_inline_v4" {
  name        = "c2cgap-vpc056-inline-v4"
  description = "inline egress to 0.0.0.0/0"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Rule = "VPC-056"
  }
}

resource "aws_security_group" "vpc056_inline_v6" {
  name        = "c2cgap-vpc056-inline-v6"
  description = "inline egress to ::/0"
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Rule = "VPC-056"
  }
}

resource "aws_security_group" "vpc056_dynamic" {
  name        = "c2cgap-vpc056-dynamic"
  description = "dynamic egress block from local"
  vpc_id      = var.vpc_id

  dynamic "egress" {
    for_each = local.vpc056_egress_cidrs
    content {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [egress.value]
    }
  }

  tags = {
    Rule = "VPC-056"
  }
}

resource "aws_security_group" "vpc056_sgrule" {
  name        = "c2cgap-vpc056-sgrule"
  description = "egress via aws_security_group_rule"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-056"
  }
}

resource "aws_security_group_rule" "vpc056_sgrule_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpc056_sgrule.id
}

resource "aws_security_group" "vpc056_egressrule" {
  name        = "c2cgap-vpc056-egressrule"
  description = "egress via aws_vpc_security_group_egress_rule"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-056"
  }
}

resource "aws_vpc_security_group_egress_rule" "vpc056_egressrule_all" {
  security_group_id = aws_security_group.vpc056_egressrule.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Rule = "VPC-056"
  }
}

resource "awscc_ec2_security_group" "vpc056_cc_explicit" {
  group_name        = "c2cgap-vpc056-cc-explicit"
  group_description = "awscc explicit egress to 0.0.0.0/0"
  vpc_id            = var.vpc_id
  security_group_egress = [{
    ip_protocol = "-1"
    cidr_ip     = "0.0.0.0/0"
  }]

  tags = [{
    key   = "Rule"
    value = "VPC-056"
  }]
}

resource "awscc_ec2_security_group" "vpc056_cc_default" {
  group_name        = "c2cgap-vpc056-cc-default"
  group_description = "awscc without egress keeps AWS default allow-all"
  vpc_id            = var.vpc_id

  tags = [{
    key   = "Rule"
    value = "VPC-056"
  }]
}

resource "aws_security_group" "vpc056_unnamed_sgr" {
  description = "no name argument, egress via aws_security_group_rule"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-056"
  }
}

resource "aws_security_group_rule" "vpc056_unnamed_sgr_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpc056_unnamed_sgr.id
}

resource "aws_security_group" "vpc056_unnamed_er" {
  description = "no name argument, egress via aws_vpc_security_group_egress_rule"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-056"
  }
}

resource "aws_vpc_security_group_egress_rule" "vpc056_unnamed_er_all" {
  security_group_id = aws_security_group.vpc056_unnamed_er.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

  tags = {
    Rule = "VPC-056"
  }
}

resource "aws_security_group" "c2cgap-vpc056-samename" {
  name        = "c2cgap-vpc056-samename"
  description = "name equals label, egress via aws_security_group_rule"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-056"
  }
}

resource "aws_security_group_rule" "c2cgap-vpc056-samename-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.c2cgap-vpc056-samename.id
}

resource "aws_security_group" "vpc056_varcidr" {
  name        = "c2cgap-vpc056-varcidr"
  description = "inline egress with cidr_blocks from local"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.vpc056_egress_cidrs
  }

  tags = {
    Rule = "VPC-056"
  }
}

locals {
  vpc056_egress_cidrs = ["0.0.0.0/0"]
  vpc056_local_sg_id  = aws_security_group.vpc056_localref.id
}

resource "aws_security_group" "vpc056_localref" {
  name        = "c2cgap-vpc056-localref"
  description = "egress via aws_security_group_rule referencing the SG through a local"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-056"
  }
}

resource "aws_security_group_rule" "vpc056_localref_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.vpc056_local_sg_id
}
