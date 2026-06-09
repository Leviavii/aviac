variable "vpc_id" {}

resource "aws_security_group" "wiz_vpc_052" {
  name        = "wiz-vpc-052-sg"
  description = "Misconfigured SG for VPC-052"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 9200
    to_port     = 9300
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
    Name    = "wiz-vpc-052"
    Project = "wiz-policy-testing"
  }
}
