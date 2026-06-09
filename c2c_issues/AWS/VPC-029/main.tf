variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_029" {
  name        = "wiz-vpc-029-sg"
  description = "Misconfigured SG for VPC-029"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
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
    Name    = "wiz-vpc-029"
    Project = "wiz-policy-testing"
  }
}
