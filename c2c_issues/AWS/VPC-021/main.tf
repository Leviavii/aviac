variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_021" {
  name        = "wiz-vpc-021-sg"
  description = "Misconfigured SG for VPC-021"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 445
    to_port     = 445
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
    Name    = "wiz-vpc-021"
    Project = "wiz-policy-testing"
  }
}
