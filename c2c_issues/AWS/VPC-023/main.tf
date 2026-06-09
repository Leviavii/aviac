variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_023" {
  name        = "wiz-vpc-023-sg"
  description = "Misconfigured SG for VPC-023"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 53
    to_port     = 53
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
    Name    = "wiz-vpc-023"
    Project = "wiz-policy-testing"
  }
}
