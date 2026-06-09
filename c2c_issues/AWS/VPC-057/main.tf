variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_057" {
  name        = "wiz-vpc-057-sg"
  description = "Misconfigured SG for VPC-057"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5601
    to_port     = 5601
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
    Name    = "wiz-vpc-057"
    Project = "wiz-policy-testing"
  }
}
