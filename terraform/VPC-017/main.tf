variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_017" {
  name        = "wiz-vpc-017-sg"
  description = "Misconfigured SG for VPC-017"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5500
    to_port     = 5500
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
    Name    = "wiz-vpc-017"
    Project = "wiz-policy-testing"
  }
}
