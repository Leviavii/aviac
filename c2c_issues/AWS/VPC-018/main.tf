variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_018" {
  name        = "wiz-vpc-018-sg"
  description = "Misconfigured SG for VPC-018"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5900
    to_port     = 5900
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
    Name    = "wiz-vpc-018"
    Project = "wiz-policy-testing"
  }
}
