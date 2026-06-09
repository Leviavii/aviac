variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_093" {
  name        = "wiz-vpc-093-sg"
  description = "Misconfigured SG for VPC-093"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
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
    Name    = "wiz-vpc-093"
    Project = "wiz-policy-testing"
  }
}
