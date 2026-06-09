variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_031" {
  name        = "wiz-vpc-031-sg"
  description = "Misconfigured SG for VPC-031"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 1434
    to_port     = 1434
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "wiz-vpc-031"
    Project = "wiz-policy-testing"
  }
}
