resource "aws_security_group" "vpc076_inline" {
  name        = "c2cgap-vpc076-inline"
  description = "Web servers"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Rule = "VPC-076"
  }
}

resource "aws_security_group" "vpc076_sgrule" {
  name        = "c2cgap-vpc076-sgrule"
  description = "App servers"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-076"
  }
}

resource "aws_security_group_rule" "vpc076_sgrule_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.vpc076_sgrule.id
}

resource "aws_security_group" "vpc076_vpcingress" {
  name        = "c2cgap-vpc076-vpcingress"
  description = "API servers"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-076"
  }
}

resource "aws_vpc_security_group_ingress_rule" "vpc076_vpcingress_https" {
  security_group_id = aws_security_group.vpc076_vpcingress.id
  cidr_ipv4         = "10.0.0.0/16"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"

  tags = {
    Rule = "VPC-076"
  }
}

resource "aws_security_group" "vpc076_vpcegress" {
  name        = "c2cgap-vpc076-vpcegress"
  description = "Worker nodes"
  vpc_id      = var.vpc_id

  tags = {
    Rule = "VPC-076"
  }
}

resource "aws_vpc_security_group_egress_rule" "vpc076_vpcegress_all" {
  security_group_id = aws_security_group.vpc076_vpcegress.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Rule = "VPC-076"
  }
}

resource "aws_security_group" "vpc076_dynamic" {
  name        = "c2cgap-vpc076-dynamic"
  description = "Internal services"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [22, 443]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    }
  }

  tags = {
    Rule = "VPC-076"
  }
}

resource "awscc_ec2_security_group" "vpc076_awscc_explicit" {
  group_name        = "c2cgap-vpc076-awscc-explicit"
  group_description = "Web servers"
  vpc_id            = var.vpc_id

  security_group_ingress = [{
    ip_protocol = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_ip     = "10.0.0.0/16"
  }]

  security_group_egress = [{
    description = "All outbound"
    ip_protocol = "-1"
    cidr_ip     = "0.0.0.0/0"
  }]

  tags = [{
    key   = "Rule"
    value = "VPC-076"
  }]
}

resource "awscc_ec2_security_group" "vpc076_awscc_default" {
  group_name        = "c2cgap-vpc076-awscc-default"
  group_description = "Web servers"
  vpc_id            = var.vpc_id

  security_group_ingress = [{
    description = "HTTPS from VPC"
    ip_protocol = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_ip     = "10.0.0.0/16"
  }]

  tags = [{
    key   = "Rule"
    value = "VPC-076"
  }]
}

resource "aws_security_group" "vpc076_egressinline" {
  name        = "c2cgap-vpc076-egressinline"
  description = "Batch workers"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Rule = "VPC-076"
  }
}
