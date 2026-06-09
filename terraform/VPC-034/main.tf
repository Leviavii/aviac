variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_034" {
  name        = "wiz-vpc-034-sg"
  description = "Misconfigured SG for VPC-034"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3389
    to_port     = 3389
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
    Name    = "wiz-vpc-034"
    Project = "wiz-policy-testing"
  }
}
