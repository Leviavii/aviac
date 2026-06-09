variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_053" {
  name        = "wiz-vpc-053-sg"
  description = "Misconfigured SG for VPC-053"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 389
    to_port     = 399
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
    Name    = "wiz-vpc-053"
    Project = "wiz-policy-testing"
  }
}
