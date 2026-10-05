variable "vpc_id" {}

variable "ssh_ingress_cidr_blocks" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

resource "aws_security_group" "wiz_vpc_015" {
  name        = "wiz-vpc-015-sg"
  description = "Misconfigured SG for VPC-015"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "wiz-vpc-015"
    Project = "wiz-policy-testing"
  }
}
