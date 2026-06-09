variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_108" {
  name        = "wiz-vpc-108-sg"
  description = "Misconfigured SG for VPC-108"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 20
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "wiz-vpc-108"
    Project = "wiz-policy-testing"
  }
}
