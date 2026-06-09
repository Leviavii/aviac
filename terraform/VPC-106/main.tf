variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_106" {
  name        = "wiz-vpc-106-sg"
  description = "Misconfigured SG for VPC-106"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "wiz-vpc-106"
    Project = "wiz-policy-testing"
  }
}
