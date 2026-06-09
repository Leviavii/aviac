variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_028" {
  name        = "wiz-vpc-028-sg"
  description = "Misconfigured SG for VPC-028"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 137
    to_port     = 137
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
    Name    = "wiz-vpc-028"
    Project = "wiz-policy-testing"
  }
}
