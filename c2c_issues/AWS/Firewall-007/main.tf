variable "vpc_id" {}

resource "aws_security_group" "wiz_firewall_007" {
  name        = "wiz-firewall-007-sg"
  description = "Misconfigured SG for Firewall-007"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "wiz-firewall-007"
    Project = "wiz-policy-testing"
  }
}
