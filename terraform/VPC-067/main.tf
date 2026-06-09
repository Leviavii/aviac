variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_067" {
  name        = "wiz-vpc-067-sg"
  description = "Misconfigured SG for VPC-067"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5984
    to_port     = 5984
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
    Name    = "wiz-vpc-067"
    Project = "wiz-policy-testing"
  }
}
