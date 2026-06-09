variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_064" {
  name        = "wiz-vpc-064-sg"
  description = "Misconfigured SG for VPC-064"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 44
    to_port     = 443
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
    Name    = "wiz-vpc-064"
    Project = "wiz-policy-testing"
  }
}
