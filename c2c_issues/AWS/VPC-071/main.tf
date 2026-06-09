variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_071" {
  name        = "wiz-vpc-071-sg"
  description = "Misconfigured SG for VPC-071"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 7574
    to_port     = 7574
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
    Name    = "wiz-vpc-071"
    Project = "wiz-policy-testing"
  }
}
