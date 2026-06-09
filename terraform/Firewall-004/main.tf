variable "vpc_id" {}

resource "aws_security_group" "wiz_firewall_004" {
  name        = "wiz-firewall-004-sg"
  description = "Misconfigured SG for Firewall-004"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 27017
    to_port     = 27019
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
    Name    = "wiz-firewall-004"
    Project = "wiz-policy-testing"
  }
}
