variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_026" {
  name        = "wiz-vpc-026-sg"
  description = "Misconfigured SG for VPC-026"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 4333
    to_port     = 4333
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "wiz-vpc-026"
    Project = "wiz-policy-testing"
  }
}
